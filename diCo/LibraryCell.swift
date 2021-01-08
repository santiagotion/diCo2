//
//  LibraryCell.swift
//  diCo
//
//  Created by Samsony Tuala on 1/8/21.
//  Copyright © 2021 lgdev. All rights reserved.
//

import UIKit

class LibraryCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    
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
        super.awakeFromNib()
        // Initialization code
        let randomIndex = Int(arc4random_uniform(UInt32(imagesArray.count)))
        
        backgroundImage.image =  UIImage(named: imagesArray[randomIndex])
    }

    @IBAction func play_sound(_ sender: Any) {
        delegate?.playSound(url: dict.audio)
    }
}
