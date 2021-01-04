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
    
    var wordToPass: Word!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataHolder.dict_data.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as! PLibraryCell
        cell.setMeaning(dictionary: DataHolder.dict_data[indexPath.row])
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Being selected")
        wordToPass = DataHolder.dict_data[indexPath.item]
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
