//
//  WelcomeVC.swift
//  diCo
//
//  Created by Santi on 17/08/2020.
//  Copyright © 2020 lgdev. All rights reserved.
//

import UIKit
import Firebase

class WelcomeVC: UIViewController {

    @IBOutlet weak var lgbit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.white.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func kfkkf(_ sender: Any) {
        
        let ref = Database.database().reference()
        
        print(ref)

        ref.child("Enormity").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let score = value?["Audio"] as? String ?? ""
                print(score)

                // ...
            }) { (error) in
                    print(error.localizedDescription)
        }
        
        
//        let databaseRef = Database.database().reference().child("users").child("jojo")
//
//        let userObject = [
//            "email": "uid"
//
//
//            ] as [String:Any]
//
//        databaseRef.updateChildValues(userObject)
   }
    

}

