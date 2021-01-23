//
//  definitionCell.swift
//  diCo
//
//  Created by Samsony Tuala on 12/28/20.
//  Copyright © 2020 lgdev. All rights reserved.
//

import UIKit

class definitionCell: UITableViewCell {
    
    @IBOutlet weak var definition: UILabel!
    @IBOutlet weak var example: UILabel!
    
    // Contains the pair of definition and example
    
    func SetMeaning(my_definition: Definition) {
        definition.text = my_definition.definition
        example.text = my_definition.example
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
