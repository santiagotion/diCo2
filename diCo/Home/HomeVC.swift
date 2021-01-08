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
    
    var wordToPass: Word!
    var audioPlayer:AVAudioPlayer!

    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    var filteredData: [String]!
    
    var data = [String]()
    //var dict_data = [MyDict]()
    var recent_ele : [Word]!
    
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
            let frequency_snapshot = snapshot.childSnapshot(forPath: "Frequency")
            let date_snapshot = snapshot.childSnapshot(forPath: "Date")
            let meanings_snapshot = snapshot.childSnapshot(forPath: "Meanings")
            var t_audio = ""
            var t_word = ""
            var frequency = 1
            var date = 0.0
            var meanings: [Any] = []
            let audio = a_snapshot.value as? String
            let word = w_snapshot.value as? String
            if let actualWord = word{
                t_word = actualWord
            }
            if let actualAudio = audio
            {
                t_audio = actualAudio
            }
            if let t_frequency = frequency_snapshot.value as? Int {
                frequency = t_frequency
            }
            if let t_date = date_snapshot.value as? Double {
                date = t_date
            }
            if let t_meanings = meanings_snapshot.value as? [Any] {
                meanings = t_meanings
            }
            let General_word = Word(word: t_word, audio: t_audio, date: date, frequency: frequency, json: meanings)
            DataHolder.dict_data.append(General_word)
            //self.recent_ele.append(General_word)
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
        1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataHolder.dict_data.count
        //return recent_ele.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! RecentCell
        cell.setMeaning(dictionary: DataHolder.dict_data.sorted(by: {$0.date > $1.date})[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        wordToPass = DataHolder.dict_data.sorted(by: {$0.date > $1.date})[indexPath.item]
        self.performSegue(withIdentifier: "toDetails2", sender: indexPath)
    }
    
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataHolder.dict_data.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as! PopularCell
        cell.setMeaning(dictionary: DataHolder.dict_data.sorted(by: {$0.frequency > $1.frequency})[indexPath.row])
        cell.delegate = self
        return cell
           
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        wordToPass = DataHolder.dict_data.sorted(by: {$0.frequency > $1.frequency})[indexPath.item]
        self.performSegue(withIdentifier: "toDetails2", sender: indexPath)
        //print("Being selected")
    }
    
    
     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailsVC {
            detailViewController.selectedWord = wordToPass
        }
    }
   

}

extension HomeVC: TableViewDelegate{
    func playSound(url: String) {
        PlaySound.playSound(url: url)
    }
}
