//
//  RecentCell.swift
//  diCo
//
//  Created by Santi on 19/08/2020.
//  Copyright © 2020 lgdev. All rights reserved.
//

import UIKit

class RecentCell: UICollectionViewCell {
    @IBOutlet weak var bacgroungColor: UIView!
    @IBOutlet weak var cellContentView: UIView!
    
    
    override func awakeFromNib() {
        
        let colorRa = UIColor.random().darker(by: 5)
        
       // colorRa.darker(by: 30)
        
        self.bacgroungColor.backgroundColor =  colorRa
        self.bacgroungColor.layer.shadowColor =  colorRa?.cgColor
        
        self.bacgroungColor.layer.shadowOpacity = 0.6
        self.bacgroungColor.layer.shadowOffset = .init(width: 0, height: 0)
        self.bacgroungColor.layer.shadowRadius = 8
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

extension UIColor {

    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}

