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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            searchField.overrideUserInterfaceStyle = .light
           
           
        }
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetails1", sender: indexPath)
        
        print("Hello Santi, this is Nathan from heaven. Because I don't care hejbsbcd hvjdv")
        print("Franchement copding sucks,there is nothing fun, please there is one fun thing and we all know about. That's how we came around")
        
        print("Hello Santi, this is Nathan from heaven. Because I don't care hejbsbcd hvjdv")
        print("ljetngkeamlgjnaehrngpowjkmnrGKHNwpkrgmnojqejrgljnearpogjaewlpjkRMGNJKHAEJRPGKMNwkhrgnlkaerjgnjnjck;sdjrgnchejmrfo;jwnhkFBJ")
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath)
        return cell
        
    }
    

}
