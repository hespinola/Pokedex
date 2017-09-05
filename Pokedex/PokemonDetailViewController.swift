//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Isomi on 9/4/16.
//  Copyright © 2016 Isomi. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var pokedexID: UILabel!
    @IBOutlet weak var hpLbl: UILabel!
    @IBOutlet weak var hp: UILabel!
    @IBOutlet weak var atkLbl: UILabel!
    @IBOutlet weak var atk: UILabel!
    @IBOutlet weak var defLbl: UILabel!
    @IBOutlet weak var def: UILabel!
    @IBOutlet weak var spDef: UILabel!
    @IBOutlet weak var spDefLbl: UILabel!
    @IBOutlet weak var spAtk: UILabel!
    @IBOutlet weak var spAtkLbl: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var nextEvolutionLbl: UILabel!
    @IBOutlet weak var currentEvo: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        divider.isHidden = true
        
        divider.delegate = self
        divider.dataSource = self
        
        nameLbl.text = pokemon.name
        pokeImg.image = UIImage(named: "\(pokemon.id)")
        currentEvo.image = UIImage(named: "\(pokemon.id)")
        idLbl.text = "\(pokemon.id)"
        
        pokemon.downloadData {
            self.updateUI()
            self.divider.reloadData()
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
    
    @IBAction func segmentedChange(_ sender: AnyObject) {
        
        if segmentedController.selectedSegmentIndex == 0 {
            nameLbl.isHidden = false
            typeLbl.isHidden = false
            idLbl.isHidden = false
            hpLbl.isHidden = false
            atkLbl.isHidden = false
            defLbl.isHidden = false
            spDefLbl.isHidden = false
            spAtkLbl.isHidden = false
            speedLbl.isHidden = false
            pokeImg.isHidden = false
            descriptionLbl.isHidden = false
            nextEvolutionLbl.isHidden = false
            currentEvo.isHidden = false
            nextEvolutionImg.isHidden = false
            hp.isHidden = false
            atk.isHidden = false
            pokedexID.isHidden = false
            type.isHidden = false
            def.isHidden = false
            spAtk.isHidden = false
            spDef.isHidden = false
            speed.isHidden = false
            
            divider.isHidden = true
        }
        
        if segmentedController.selectedSegmentIndex == 1 {
            nameLbl.isHidden = true
            typeLbl.isHidden = true
            idLbl.isHidden = true
            hpLbl.isHidden = true
            atkLbl.isHidden = true
            defLbl.isHidden = true
            spDefLbl.isHidden = true
            spAtkLbl.isHidden = true
            speedLbl.isHidden = true
            pokeImg.isHidden = true
            descriptionLbl.isHidden = true
            nextEvolutionLbl.isHidden = true
            currentEvo.isHidden = true
            nextEvolutionImg.isHidden = true
            hp.isHidden = true
            atk.isHidden = true
            pokedexID.isHidden = true
            type.isHidden = true
            def.isHidden = true
            spAtk.isHidden = true
            spDef.isHidden = true
            speed.isHidden = true
        }
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.movement.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PokeMove") as? PokeMove {
            
            cell.movement = pokemon.movement[indexPath.row]
            cell.updateUI()
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
}
