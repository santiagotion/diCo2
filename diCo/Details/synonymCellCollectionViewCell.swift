//
//  synonymCellCollectionViewCell.swift
//  diCo
//
//  Created by Samsony Tuala on 12/27/20.
//  Copyright © 2020 lgdev. All rights reserved.
//

import UIKit

class synonymCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    func setTitle(my_title: String) {
        title.text = my_title
    }
}
