//
//  PopularCell.swift
//  diCo
//
//  Created by Santi on 19/08/2020.
//  Copyright © 2020 lgdev. All rights reserved.
//

import UIKit

class PopularCell: UITableViewCell {
    
   
    @IBOutlet weak var bacgroundImage: UIImageView!
    
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
    
    
    
    override func awakeFromNib() {
        let randomIndex = Int(arc4random_uniform(UInt32(imagesArray.count)))
        
        bacgroundImage.image =  UIImage(named: imagesArray[randomIndex])
    }
    
}


