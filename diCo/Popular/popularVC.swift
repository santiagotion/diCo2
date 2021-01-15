//
//  popularVC.swift
//  diCo
//
//  Created by Santi on 19/08/2020.
//  Copyright © 2020 lgdev. All rights reserved.
//

import UIKit

class popularVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearch: Bool = false
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredWords : [Word] = []
    
    var wordToPass: Word!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.allowsSelectionDuringEditing = true
        
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
        
        //searchController.searchBar.clipsToBounds = true
        searchBar.delegate = self
        
        //searchBar.showsCancelButton = true
        
    }
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    func filterContentForSearchText (_ searchText: String) {
        filteredWords = DataHolder.dict_data.filter { (word: Word) -> Bool in
            return word.word.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            //print(tableView.allowsSelectionDuringEditing)
            return filteredWords.count
        }
        return DataHolder.dict_data.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as! PLibraryCell
        let word:Word
        if isSearch {
            word = filteredWords.sorted(by: {$0.frequency > $1.frequency})[indexPath.row]
        }else {
            word = DataHolder.dict_data.sorted(by: {$0.frequency > $1.frequency})[indexPath.row]
        }
        cell.setMeaning(dictionary: word)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearch {
            wordToPass = filteredWords.sorted(by: {$0.frequency > $1.frequency})[indexPath.row]
        }else {
            wordToPass = DataHolder.dict_data.sorted(by: {$0.frequency > $1.frequency})[indexPath.row]
        }
        self.performSegue(withIdentifier: "todetails3", sender: indexPath)
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
extension popularVC: TableViewDelegate{
    func playSound(url: String) {
        PlaySound.playSound(url: url)
    }
}

extension popularVC : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension popularVC : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true;
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false;
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //print("Reaching here ever")
        searchBar.resignFirstResponder()
        
        isSearch = false
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty) {
            //filterContentForSearchText (searchText)
            isSearch = false
            tableView.reloadData()
        }else {
            isSearch = true
            filterContentForSearchText (searchText)
        }
        
    }
}
