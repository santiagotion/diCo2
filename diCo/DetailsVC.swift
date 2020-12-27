//
//  DetailsVC.swift
//  diCo
//
//  Created by Santi on 02/09/2020.
//  Copyright © 2020 lgdev. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    //var selectedWord : Class!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 6
      }
      
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return 1
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
       
            
          
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "synonymsCell", for: indexPath)
          
          return cell
    
        
      }
      
      
      
      
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return 3
         }
         
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
             let cell = tableView.dequeueReusableCell(withIdentifier: "definitionCell", for: indexPath)
             return cell
             
         }

}
