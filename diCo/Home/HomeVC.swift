//
//  HomeVC.swift
//  diCo
//
//  Created by Santi on 17/08/2020.
//  Copyright © 2020 lgdev. All rights reserved.
//

import UIKit

import FirebaseDatabase

import AVFoundation
import AVKit

class HomeVC: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewContraintHeight: NSLayoutConstraint!
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var audioPlayer:AVAudioPlayer!

    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    var filteredData: [String]!
    
    var data = [String]()
    //var dict_data = [MyDict]()
    var meaningData = [Meanings]()
    
    //var wordToPass : Class!
    
   // var class = [Class]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            searchField.overrideUserInterfaceStyle = .light
        }
        
        ref = Database.database().reference()
        tableView.dataSource = self
        collectionView.dataSource = self
        //searchBar.delegate = self
        
        // Retrieve the post and listen for changes
        filteredData = data
        databaseHandle = ref?.observe(.childAdded, with: { (snapshot) in
            // Code to execute when a new word is added
            let w_snapshot = snapshot.childSnapshot(forPath: "Word")
            let a_snapshot = snapshot.childSnapshot(forPath: "Audio")
            var t_audio = ""
            var t_word = ""
            let audio = a_snapshot.value as? String
            let word = w_snapshot.value as? String
            if let actualWord = word{
                //self.data.append(actualWord)
                //self.filteredData = self.data
                //self.tableView.reloadData()
                t_word = actualWord
            }
            if let actualAudio = audio
            {
                t_audio = actualAudio
            }
            let dict = MyDict(word: t_word, audio: t_audio)
            DataHolder.dict_data.append(dict)
            self.tableView.reloadData()
            self.collectionView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // Keep track of size of the vertical table view
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath ==  "contentSize" {
            if let newvalue = change?[.newKey]{
                let newSize = newvalue as! CGSize
                self.tableViewContraintHeight.constant = newSize.height
            }
            
        }
    }
    
    
    
    
    
    
    
    // Populate collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        DataHolder.dict_data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataHolder.dict_data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! RecentCell
        cell.setMeaning(dictionary: DataHolder.dict_data[indexPath.row])
        cell.delegate = self
        return cell
  
      
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        wordToPass = class[indexPath.item]
        self.performSegue(withIdentifier: "toDetails2", sender: indexPath)
    }
    
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataHolder.dict_data.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as! PopularCell
        cell.setMeaning(dictionary: DataHolder.dict_data[indexPath.row])
        cell.delegate = self
        return cell
           
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        wordToPass = class[indexPath.item]
        
        self.performSegue(withIdentifier: "toDetails2", sender: indexPath)
        
    }
    
    
     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailsVC {
            
         // detailViewController.selectedWord = wordToPass
        }
    }
   

}

extension HomeVC: TableViewDelegate{
    func playSound(url: String) {
        //print(url)
        guard let c_url = URL(string: url) else { return}
        downloadFileFromURL(url: c_url)
    }
    func downloadFileFromURL(url: URL){
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url) { (url, response, error) in
            self.play(url: url!)
        }
        downloadTask.resume()
    }
    func play(url:URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url as URL)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 2.0
            audioPlayer.play()
        } catch let error as NSError {
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
}
