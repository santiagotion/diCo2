//
//  newHomeVC.swift
//  diCo
//
//  Created by User on 21/01/2021.
//  Copyright © 2021 lgdev. All rights reserved.
//

import UIKit

class newHomeVC: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: "cell47", for: indexPath)
        
    }
    
   
    
    @IBOutlet weak var uiViewff: UIView!
    @IBOutlet weak var tex: UILabel!
    @IBOutlet weak var btnView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnView.layer.shadowColor =  UIColor.lightGray.cgColor
        
        self.btnView.layer.shadowOpacity = 0.3
        self.btnView.layer.shadowOffset = .init(width: 0, height: 0)
        self.btnView.layer.shadowRadius = 8
        
        
//        let gradient = CAGradientLayer()
//
//        // gradient colors in order which they will visually appear
//        gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
//
//        // Gradient from left to right
//        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
//        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
//
//        // set the gradient layer to the same size as the view
//        gradient.frame = uiViewff.bounds
//
//        uiViewff.layer.addSublayer(gradient)
//
//        let label = UILabel(frame: uiViewff.bounds)
//        label.text = "Hello World"
//        label.font = UIFont.boldSystemFont(ofSize: 30)
//        label.textAlignment = .center
//        uiViewff.addSubview(tex)
//
//        // Tha magic! Set the label as the views mask
//        uiViewff.mask = tex
        
       

       

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


class CardLayoutAttributes: UICollectionViewLayoutAttributes {
    var isExpand = false

    override func copy(with zone: NSZone? = nil) -> Any {
        let attribute = super.copy(with: zone) as! CardLayoutAttributes
        attribute.isExpand = isExpand
        return attribute
    }
}
