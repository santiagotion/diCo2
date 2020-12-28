//
//  DetailsVC.swift
//  diCo
//
//  Created by Santi on 02/09/2020.
//  Copyright © 2020 lgdev. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var defTableView: UITableView!
    
    @IBOutlet weak var pageTitle: UILabel!
    
    @IBOutlet weak var partOfSpeech: UILabel!
    @IBOutlet weak var playImageView: UIImageView!
    
    var selectedWord : Word!
    var synonyms: [String]!
    var definitions: [Definition]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        defTableView.dataSource = self
        synonyms = selectedWord.meanings[0].synonyms
        definitions = selectedWord.meanings[0].definitions
        pageTitle.text = selectedWord.word
        partOfSpeech.text = selectedWord.meanings[0].partOfSpeech
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureCalled(gesture:)))
        playImageView.addGestureRecognizer(tapGesture)
        playImageView.isUserInteractionEnabled = true
    }
    
    @objc func gestureCalled(gesture:UITapGestureRecognizer) -> Void {
        PlaySound.playSound(url: selectedWord.audio)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(synonyms.count)
        return 1
      }
      
      
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return synonyms.count
    }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "synonymsCell", for: indexPath) as! synonymCellCollectionViewCell
        cell.setTitle(my_title: synonyms[indexPath.row])
        return cell
    }
      
      
      
      
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return definitions.count
    }
         
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
        let cell = tableView.dequeueReusableCell(withIdentifier: "definitionCell", for: indexPath) as! definitionCell
        cell.SetMeaning(my_definition: definitions[indexPath.row])
        return cell
             
    }

}
