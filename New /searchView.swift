//
//  searchView.swift
//  diCo
//
//  Created by User on 22/01/2021.
//  Copyright © 2021 lgdev. All rights reserved.
//

import UIKit
import FirebaseDatabase

class searchView: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
   
    
    
    var wordToSearch: String!
    var wordToPass: Word!
    var isSearch: Bool = false
    let searchController = UISearchController(searchResultsController: nil)
    var filteredWords : [Word] = []
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    var wordToFilter: String!
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchBtnBkView1: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            textField.overrideUserInterfaceStyle = .light
        }
        textField.delegate = self
        ref = Database.database().reference()
 
        
        self.searchBtnBkView1.layer.shadowColor =  UIColor.lightGray.cgColor
        
        self.searchBtnBkView1.layer.shadowOpacity = 1.0
        self.searchBtnBkView1.layer.shadowOffset = .init(width: 0, height: 1)
        self.searchBtnBkView1.layer.shadowRadius = 2
        
        newWordOberserver()

   
    }
    
    
    @IBAction func searchBtn(_ sender: Any) {
        
        
        
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
    
    func  newWordOberserver(){
        
        ref?.observe( .childAdded, with: { snapshot in
            
            print("jnjnjnj")
            
//            DataHolder.dict_data.removeAll()
//            print(snapshot.children.v)
            
            
            
            
            
            
            
            
            
            var tempWord =  [Word]()
            tempWord.removeAll()


            for child in snapshot.children.allObjects {
                tempWord.removeAll()
                if let childSnapshot = child as? DataSnapshot,
                   let dict = childSnapshot.value as? [String:Any],
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
//                    self.filterContentForSearchText(self.wordToSearch!)

                    print("OOOOOOOOOOOOOOO")
                }
                   }
//

//            DataHolder.dict_data.append(contentsOf: tempWord)
//            self.filterContentForSearchText(tempWord[0].word)
//            self.tableView.reloadData()

        print("jbjbjbjbjbjbjbjb")
            
//            if self.wordToFilter != nil {
            self.filterContentForSearchText(snapshot.key)
//                self.tableView.reloadData()
                
//                print(self.wordToFilter!)
//                print(snapshot.key)
                


//            }
            
            
            
            
        })
        
        
    }
    
    
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
       return true
    }
    
    
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{

        let searchText  = textField.text! + string
        
        
        let trimmedString = searchText.trimmingCharacters(in: .whitespaces)
        
        wordToFilter = trimmedString

        print(searchText)
        if (searchText.isEmpty) {
            isSearch = false
            tableView.reloadData()
        }else {
            isSearch = true
            filterContentForSearchText (trimmedString)
        }
//        if (!self.searchOnLine.isHidden) {
            wordToSearch = trimmedString
//        }


        return true
    }
    

    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText (_ searchText: String) {
        filteredWords = DataHolder.dict_data.filter { (word: Word) -> Bool in
            return word.word.lowercased().contains(searchText.lowercased())
        }
//        if filteredWords.count==0 {
//            self.searchOnLine.isHidden = false
//        }else {
//            self.searchOnLine.isHidden = true
//        }
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! LibraryCell
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

extension searchView: TableViewDelegate{
    func playSound(url: String) {
        PlaySound.playSound(url: url)
    }
}

