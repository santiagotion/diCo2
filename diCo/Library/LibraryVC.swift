//
//  LibraryVC.swift
//  diCo
//
//  Created by Santi on 18/08/2020.
//  Copyright © 2020 lgdev. All rights reserved.
//

import UIKit

class LibraryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var wordToPass: Word!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            searchField.overrideUserInterfaceStyle = .light
        }
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        wordToPass = DataHolder.dict_data[indexPath.item]
        self.performSegue(withIdentifier: "toDetails1", sender: indexPath)
        tableView.delegate = self
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataHolder.dict_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as! LibraryCell
        cell.setMeaning(dictionary: DataHolder.dict_data[indexPath.row])
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
