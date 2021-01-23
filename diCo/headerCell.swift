//
//  headerCell.swift
//  diCo
//
//  Created by User on 22/01/2021.
//  Copyright © 2021 lgdev. All rights reserved.
//

import UIKit

class headerCell: UICollectionViewCell {

    
    @IBOutlet weak var text: UILabel!
    
    @IBOutlet weak var icon: UIButton!
    @IBOutlet weak var bcg: UIView!
    override  func awakeFromNib() {
        let gradient = CAGradientLayer()
        
                // gradient colors in order which they will visually appear
        gradient.colors = [UIColor.init(red: 100/255, green: 43/255, blue: 239/255, alpha: 1.0).cgColor, UIColor.init(red: 243/255, green: 0/255, blue: 105/255, alpha: 1.0).cgColor,]
        
                // Gradient from left to right
        gradient.startPoint = CGPoint(x: 0.0, y: 0.4)
        
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        
                // set the gradient layer to the same size as the view
        
       
        gradient.frame = self.bcg.bounds

        bcg.layer.addSublayer(gradient)
        
//
        
                // Tha magic! Set the label as the views mask
        bcg.mask = text
        
//        bcg.addSubview([icon,text])
       
        
                // Tha magic! Set the label as the views mask
//        bcg.mask = text
        
    }
    
    
}
