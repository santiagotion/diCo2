//
//  newHomeVC.swift
//  diCo
//
//  Created by User on 21/01/2021.
//  Copyright © 2021 lgdev. All rights reserved.
//

import UIKit
import FirebaseDatabase
import AVFoundation
import AVKit

class newHomeVC: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {
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
    
    var totalWords = [String]()
    
   
    
    @IBOutlet weak var uiViewff: UIView!
    @IBOutlet weak var tex: UILabel!
    @IBOutlet weak var btnView: UIView!
    
    
//    let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
//    let fadeView:UIView = UIView()

    // waiy until main view shows
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnView.layer.shadowColor =  UIColor.white.cgColor
        
        self.btnView.layer.shadowOpacity = 1.0
        self.btnView.layer.shadowOffset = .init(width: 0, height: 10)
        self.btnView.layer.shadowRadius = 5
        
        
        
        self.uiViewff.layer.shadowColor =  UIColor.lightGray.cgColor
        
        self.uiViewff.layer.shadowOpacity = 0.8
        self.uiViewff.layer.shadowOffset = .init(width: 0, height: 0)
        self.uiViewff.layer.shadowRadius = 15
        
        ref = Database.database().reference()
        
        dataObserVer()
        
        shouldPresentLoadingView(true)
     
    }
    
    
    
    
    func  dataObserVer(){
        
       ref?.observe( .value, with: { snapshot in
            
//            DataHolder.dict_data.removeAll()
            
            for child in snapshot.children {
                
                if let childSnapshot = child as? DataSnapshot,
                   
                   let dict = childSnapshot.value as? [String:Any],
                   
//
                   let w_snapshot = dict["Word"],
                   let a_snapshot = dict["Audio"],
                   let frequency_snapshot = dict["Frequency"],
                   let date_snapshot = dict["Date"],
                   let meanings_snapshot = dict["Meanings"]{
                    
                    
                    
                    var t_audio = ""
                    var t_word = ""
                    var frequency = 1
                    var date = 0.0
                    var meanings: [Any] = []
                    let audio = a_snapshot as? String
                    let word = w_snapshot as? String
                    if let actualWord = word{
                        t_word = actualWord
                    }
                    if let actualAudio = audio
                    {
                        t_audio = actualAudio
                    }
                    if let t_frequency = frequency_snapshot as? Int {
                        frequency = t_frequency
                    }
                    if let t_date = date_snapshot as? Double {
                        date = t_date
                    }
                    if let t_meanings = meanings_snapshot as? [Any] {
                        meanings = t_meanings
                    }
                    let General_word = Word(word: t_word, audio: t_audio, date: date, frequency: frequency, json: meanings)
                    DataHolder.dict_data.append(General_word)
                    
//                    print(meanings_snapshot)
//                    self.recent_ele.append(General_word)
                    
                   
//                    self.tableView.reloadData()

                    
                   
                }
                   
                   
                   }
        self.collectionView.reloadData()
        
        self.shouldPresentLoadingView(false)
            
            
            
        })
        
        
    }
    

    
    
  
   
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      
           let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerViewCell", for: indexPath)
           // Customize headerView here
           return headerView
      
   }
   
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataHolder.dict_data.count
        //return recent_ele.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell47", for: indexPath) as! RecentCell
        cell.setMeaning(dictionary: DataHolder.dict_data.sorted(by: {$0.date > $1.date})[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        wordToPass = DataHolder.dict_data.sorted(by: {$0.date > $1.date})[indexPath.item]
        self.performSegue(withIdentifier: "toDetails2", sender: indexPath)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailsVC {
            detailViewController.selectedWord = wordToPass
        }
    }

}






extension newHomeVC: TableViewDelegate{
func playSound(url: String) {
    PlaySound.playSound(url: url)
}
}
