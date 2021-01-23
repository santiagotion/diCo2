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
    //    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var textView: UIView!
    
    @IBOutlet weak var seemoreBtn: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var cellConstraintWi: NSLayoutConstraint!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var partOfSpe: UILabel!
    
    var dict : Word!
    
    
   
    
    var delegate : TableViewDelegate?
    
    override func awakeFromNib() {
        
        let gradient = CAGradientLayer()
        
                // gradient colors in order which they will visually appear
        gradient.colors = [UIColor.init(red: 100/255, green: 43/255, blue: 239/255, alpha: 1.0).cgColor, UIColor.init(red: 243/255, green: 0/255, blue: 105/255, alpha: 1.0).cgColor,]
        
                // Gradient from left to right
        gradient.startPoint = CGPoint(x: 0.5, y: 0.6)
        
                gradient.endPoint = CGPoint(x: 1.0, y: 0.2)
        
                // set the gradient layer to the same size as the view
                gradient.frame = bacgroungColor.bounds
        
        let gradient2 = CAGradientLayer()

                // gradient colors in order which they will visually appear
        gradient2.colors = [UIColor.init(red: 100/255, green: 43/255, blue: 239/255, alpha: 1.0).cgColor, UIColor.init(red: 243/255, green: 0/255, blue: 105/255, alpha: 1.0).cgColor,]

                // Gradient from left to right
        gradient2.startPoint = CGPoint(x: 0.5, y: 0.6)

                gradient2.endPoint = CGPoint(x: 1.0, y: 0.2)

                // set the gradient layer to the same size as the view
                gradient2.frame = textView.bounds

        bacgroungColor.layer.addSublayer(gradient)
        textView.layer.addSublayer(gradient2)
        textView.mask = seemoreBtn

        
//        cellConstraintWi.constant = UIScreen.main.bounds.width - 30
//        self.bacgroungColor.frame.size.width = UIScreen.main.bounds.width - 30
        
//        let colorRa = UIColor.random().darker(by: 15)
//        
//       // colorRa.darker(by: 30)
//        // Modify UI(Decoration)
//        self.bacgroungColor.backgroundColor =  colorRa
//        self.bacgroungColor.layer.shadowColor =  colorRa?.cgColor
//        
//        self.bacgroungColor.layer.shadowOpacity = 0.6
//        self.bacgroungColor.layer.shadowOffset = .init(width: 0, height: 0)
//        self.bacgroungColor.layer.shadowRadius = 8
        //End
        
    }
    func setMeaning(dictionary: Word)
    {
        dict = dictionary
        title.text = dictionary.word
        partOfSpe.text = dictionary.meanings[0].partOfSpeech
        var counter = 1
        var text: String = ""
        if (dictionary.meanings.count > 0) {
            for definition in dictionary.meanings[0].definitions {
                text = text + String(counter)+":"+definition.definition + "\n"
                counter = counter + 1
                if (counter == 3){
                    break
                }
            }
        }
        //message.text = dictionary.meanings[0].definitions[0].definition
        message.text = text
    }
    @IBAction func play_sound(_ sender: Any) {
        delegate?.playSound(url: dict.audio)
    }
    
    
}

// Decoration ezo continuer
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

// Suka
