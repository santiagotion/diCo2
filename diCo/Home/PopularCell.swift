//
//  PopularCell.swift
//  diCo
//
//  Created by Santi on 19/08/2020.
//  Copyright © 2020 lgdev. All rights reserved.
//

import UIKit

protocol TableViewDelegate {
    func playSound(url: String)
}

class PopularCell: UITableViewCell {
    
   
    @IBOutlet weak var bacgroundImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var message: UILabel!
    
    var dict : Word!
    
    var delegate : TableViewDelegate?
    
    let imagesArray = [
        "image1",
        "image2",
        "image3",
        "image4",
        "image5",
        "image6",
        "image7",
        "image8",
        "image9",
    ]
    func setMeaning(dictionary: Word)
    {
        dict = dictionary
        title.text = dictionary.word
        var text: String = "Missing"
        if dictionary.meanings.count > 0 {
            if (dictionary.meanings[0].definitions.count > 0) {
                text = dictionary.meanings[0].definitions[0].definition
            }
        }
        message.text = text
    }
    
    override func awakeFromNib() {
        let randomIndex = Int(arc4random_uniform(UInt32(imagesArray.count)))
        
        bacgroundImage.image =  UIImage(named: imagesArray[randomIndex])
    }
    
    @IBAction func play_sound(_ sender: Any) {
        delegate?.playSound(url: dict.audio)
    }
    
    
}

