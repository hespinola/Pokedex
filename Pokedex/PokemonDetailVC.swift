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
        
        pokemon.downloadData {
            self.updateUI()
        }
    }
    
    func updateUI() {
        typeLbl.text = pokemon.type
        idLbl.text = "\(pokemon.id)"
        hpLbl.text = "\(pokemon.hp)"
        atkLbl.text = "\(pokemon.attack)"
        defLbl.text = "\(pokemon.defense)"
        spDefLbl.text = "\(pokemon.spcDef)"
        spAtkLbl.text = "\(pokemon.spcAtk)"
        speedLbl.text = "\(pokemon.speed)"
        pokeImg.image = UIImage(named: "\(pokemon.id)")
        descriptionLbl.text = pokemon.description
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
