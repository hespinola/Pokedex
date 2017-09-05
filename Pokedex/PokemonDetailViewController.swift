//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Isomi on 9/4/16.
//  Copyright © 2016 Isomi. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var specialDefense: UILabel!
    @IBOutlet weak var pokedexIDLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var specialAttack: UILabel!
    @IBOutlet weak var speed: UILabel!
    
    // MARK: - Class Properties
    var pokemon: Pokemon!
    
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Navigation Bar
        self.navigationItem.title = "Pokemon"
        
        // Setup UI
        pokemonImageView.image = UIImage(named: "\(pokemon.id)")
        pokemonNameLabel.text = pokemon.name
        pokedexIDLabel.text = "Pokedex ID: \(pokemon.id)"
        
        pokemon.downloadData {
            self.updateUI()
        }
    }
    
    // MARK: - Class Methods
    func updateUI() {
        typeLabel.text = "Type: " + pokemon.type
        hpLabel.text = "Hp: \(pokemon.hp)"
        defenseLabel.text = "Defense: \(pokemon.defense)"
        specialDefense.text = "Special Defense: \(pokemon.specialDefense)"
        attackLabel.text = "Attack: \(pokemon.attack)"
        specialAttack.text = "Special Attack: \(pokemon.specialAttack)"
        speed.text = "Speed: \(pokemon.speed)"
    }
}
