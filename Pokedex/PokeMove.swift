//
//  PokeMove.swift
//  Pokedex
//
//  Created by Isomi on 9/22/16.
//  Copyright © 2016 Isomi. All rights reserved.
//

import UIKit

class PokeMove: UITableViewCell {
    
    var movement: Movement!
    
    @IBOutlet weak var movementNameLbl: UILabel!
    @IBOutlet weak var movementTypeLbl: UILabel!
    @IBOutlet weak var ppLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI() {
        movementNameLbl.text = movement.name.capitalized
        movementTypeLbl.text = movement.type.capitalized
        ppLbl.text = "\(movement.pp)"
    }

}
