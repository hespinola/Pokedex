//
//  PokeCell.swift
//  Pokedex
//
//  Created by Isomi on 9/4/16.
//  Copyright © 2016 Isomi. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        
        pokeImage.image = UIImage(named: "\(self.pokemon.id)")
        pokeLabel.text = self.pokemon.name
    }
}
