//
//  LibraryVC.swift
//  diCo
//
//  Created by Santi on 18/08/2020.
//  Copyright © 2020 lgdev. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LibraryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchOnLine: UIButton!
    var wordToSearch: String!
    var wordToPass: Word!
    var isSearch: Bool = false
    let searchController = UISearchController(searchResultsController: nil)
    var filteredWords : [Word] = []
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            // searchField.overrideUserInterfaceStyle = .light
        }
        //self.myButton.isHidden = true
        ref = Database.database().reference()
        self.searchOnLine.isHidden = true
        tableView.delegate = self
        tableView.allowsSelectionDuringEditing = true
        tableView.allowsSelection = true
        
        if #available(iOS 14.0, *) {
            tableView.selectionFollowsFocus = true
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view.
        
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
    
        // 3
        searchController.searchBar.placeholder = "Search..."
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        //tableView.tableHeaderView = searchController.searchBar
        
        searchBar.delegate = self
        
        //searchBar.showsCancelButton = true
//        newWordObservver();
        
        dataObserVer()
//        newWordOberserver()
//        newWordOberserver()
//        newWordOberserver()
        
    }
    
//    func newWordObservver(){
//       
//        ref?.observeSingleEvent(of: .value, with: { snapshot in
//            DataHolder.dict_data.removeAll()
//            // Code to execute when a new word is added
//            print("III");
//            print(snapshot)
//            print("III");
//            
////            for child in snapshot.children {
//
//            let w_snapshot = snapshot.childSnapshot(forPath: "Word")
//            let a_snapshot = snapshot.childSnapshot(forPath: "Audio")
//            let frequency_snapshot = snapshot.childSnapshot(forPath: "Frequency")
//            let date_snapshot = snapshot.childSnapshot(forPath: "Date")
//                let meanings_snapshot = snapshot.childSnapshot(forPath: "Meanings")
//            
//            var t_audio = ""
//            var t_word = ""
//            var frequency = 1
//            var date = 0.0
//            var meanings: [Any] = []
//            let audio = a_snapshot.value as? String
//            let word = w_snapshot.value as? String
//            if let actualWord = word{
//                t_word = actualWord
//            }
//            if let actualAudio = audio
//            {
//                t_audio = actualAudio
//            }
//            if let t_frequency = frequency_snapshot.value as? Int {
//                frequency = t_frequency
//            }
//            if let t_date = date_snapshot.value as? Double {
//                date = t_date
//            }
//            if let t_meanings = meanings_snapshot.value as? [Any] {
//                meanings = t_meanings
//            }
//            let General_word = Word(word: t_word, audio: t_audio, date: date, frequency: frequency, json: meanings)
//            DataHolder.dict_data.append(General_word)
//            
////            print(meanings_snapshot)
//            //self.recent_ele.append(General_word)
//            self.tableView.reloadData()
//            self.filterContentForSearchText(word!)
////            }
//        })
//            
//        
//        
//    }
    
    
    func  dataObserVer(){
        
        ref?.observeSingleEvent(of: .value, with: { snapshot in
            
            DataHolder.dict_data.removeAll()
            
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
                    
        //            print(meanings_snapshot)
//                    self.recent_ele.append(General_word)
                    self.filterContentForSearchText(word!)
                    print((word ?? "") as String)
//                    self.tableView.reloadData()

                    
                   
                }
                   
                   
                   }
            
            
            
        })
        
        
    }
    
    func  newWordOberserver(){
        
        ref?.observe( .childAdded, with: { snapshot in
            
//            DataHolder.dict_data.removeAll()
//            print(snapshot.children.v)
            
            var tempWord =  [Word]()
            
            for child in snapshot.children.allObjects {
                
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
                    
                    
                    tempWord.append(General_word)
                    
        //            print(meanings_snapshot)
                    //self.recent_ele.append(General_word)
                    self.tableView.reloadData()
                    self.filterContentForSearchText(word!)
                    
                   
                }
                   
                   
                   }
            
            DataHolder.dict_data.append(contentsOf: tempWord)
            
            
            
        })
        
        
    }

    
    @IBAction func SearchOnline(_ sender: Any) {
        if let word = wordToSearch {
            Searcher.searchWordOnLine(word)
            
//            print(word)
            
            print(Searcher.wordo as Any)
            
            if let found = Searcher.found {
                if found {
                    
                    
                    
//
//
                    filterContentForSearchText(word)
                }
            }
            
        }
    }
    
    
    func searchWordOnLine (_ word : String){
        var ref:DatabaseReference?
        ref = Database.database().reference()
        
        let urll = "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)"
        let manager:MainDataManager = MainDataManager()
        var m_count = 1
        manager.getData(from: urll) { (results:[Meanings]) in
            
            var audio = ""
            if(results.count > 0)
            {
                
                
               
             
                audio = results[0].audio
                ref?.child(word).child("Word").setValue(word)
                ref?.child(word).child("Audio").setValue(audio)
                ref?.child(word).child("Date").setValue(NSDate().timeIntervalSinceReferenceDate)
                ref?.child(word).child("Frequency").setValue(1)
                
                for meaning in results
                {
                    //self.data.append(meani.partOfSpeech)
                    //self.data.append(meani.meanings[0].synonyms[0])
                    //print(self.data)
                    //print(meaning.partOfSpeech)
                    ref?.child(word).child("Meanings").child("\(m_count)").child("PartOfSpeech").setValue(meaning.partOfSpeech)
                    var d_count = 1
                    for definition in meaning.meanings
                    {
                        ref?.child(word).child("Meanings").child("\(m_count)").child("Definitions").child("\(d_count)").child("definition").setValue(definition.definition)
                        ref?.child(word).child("Meanings").child("\(m_count)").child("Definitions").child("\(d_count)").child("example").setValue(definition.example)
                        var s_count = 1;
                        for synonym in definition.synonyms
                        {
                            ref?.child(word).child("Meanings").child("\(m_count)").child("Synonyms").child("\(s_count)").setValue(synonym)
                            s_count = s_count+1
                        }
                        d_count = d_count+1
                    }
                    m_count = m_count + 1
                }
                
            }
        }
        //return manager.wordFound
    }

    
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText (_ searchText: String) {
        filteredWords = DataHolder.dict_data.filter { (word: Word) -> Bool in
            return word.word.lowercased().contains(searchText.lowercased())
        }
        if filteredWords.count==0 {
            self.searchOnLine.isHidden = false
        }else {
            self.searchOnLine.isHidden = true
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //wordToPass = DataHolder.dict_data[indexPath.item]
        if isSearch {
            wordToPass = filteredWords[indexPath.row]
        }else {
            wordToPass = DataHolder.dict_data[indexPath.row]
        }
        self.performSegue(withIdentifier: "toDetails1", sender: indexPath)
        tableView.delegate = self
        
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            return filteredWords.count
        }
        return DataHolder.dict_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as! LibraryCell
        let word:Word
        if isSearch {
            word = filteredWords[indexPath.row]
        }else {
            word = DataHolder.dict_data[indexPath.row]
        }
        cell.setMeaning(dictionary: word)
        cell.delegate = self
        return cell
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

extension LibraryVC: TableViewDelegate{
    func playSound(url: String) {
        PlaySound.playSound(url: url)
    }
}

extension LibraryVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension LibraryVC : UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true;
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearch = false
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText)
        if (searchText.isEmpty) {
            isSearch = false
            tableView.reloadData()
        }else {
            isSearch = true
            filterContentForSearchText (searchText)
        }
        if (!self.searchOnLine.isHidden) {
            wordToSearch = searchText
        }
    }
}
