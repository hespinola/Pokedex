//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Isomi on 9/4/16.
//  Copyright © 2016 Isomi. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var hpLbl: UILabel!
    @IBOutlet weak var atkLbl: UILabel!
    @IBOutlet weak var defLbl: UILabel!
    @IBOutlet weak var spDefLbl: UILabel!
    @IBOutlet weak var spAtkLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var nextEvolutionLbl: UILabel!
    @IBOutlet weak var currentEvo: UIImageView!
    @IBOutlet weak var nextEvolutionImg: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name
        pokeImg.image = UIImage(named: "\(pokemon.id)")
        currentEvo.image = UIImage(named: "\(pokemon.id)")
        idLbl.text = "\(pokemon.id)"
        
        pokemon.downloadData {
            self.updateUI()
        }
    }
    
    func updateUI() {
        typeLbl.text = pokemon.type
        hpLbl.text = "\(pokemon.hp)"
        atkLbl.text = "\(pokemon.attack)"
        defLbl.text = "\(pokemon.defense)"
        spDefLbl.text = "\(pokemon.spcDef)"
        spAtkLbl.text = "\(pokemon.spcAtk)"
        speedLbl.text = "\(pokemon.speed)"
        descriptionLbl.text = pokemon.description
        nextEvolutionImg.image = UIImage(named: pokemon.nextEvoId)
        nextEvolutionLbl.text = pokemon.nextEvo
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
