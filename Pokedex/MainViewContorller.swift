//
//  MainVC.swift
//  Pokedex
//
//  Created by Isomi on 9/4/16.
//  Copyright © 2016 Isomi. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {

    
    // MARK: - UI Elements
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Class Properties
    fileprivate var pokemons = [Pokemon]()
    fileprivate var filteredPokemons = [Pokemon]()
    fileprivate var inSearchMode = false
    private var musicPlayer: AVAudioPlayer!
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Navigation Bar        
        self.navigationItem.title = APP_NAME
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: AppStyles.Font.Title
        ]
        
        let musicButton = UIBarButtonItem(image: UIImage(named: "music"), style: .plain, target: self, action: #selector(musicButtonPressed(sender:)))
        musicButton.tintColor = UIColor.white
        musicButton.imageInsets = UIEdgeInsetsMake(35, 70, 35, 0)
        
        self.navigationItem.rightBarButtonItem = musicButton
        
        // Configure Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        // Configure Search Bar
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        
        parsePokemonCSV()
        initAudio()
    }
    
    // MARK: - Class Methods
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            // Loop rows
            for row in rows {
                let id = Int(row["id"]!)
                let name = row["identifier"]!
                let pokemon = Pokemon(name: name, id: id!)
                pokemons.append(pokemon)
            }
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    func musicButtonPressed(sender: UIBarButtonItem) {
        if musicPlayer.isPlaying {
            musicPlayer.stop()
            sender.tintColor = UIColor.white.withAlphaComponent(0.7)
        } else {
            musicPlayer.play()
            sender.tintColor = UIColor.white.withAlphaComponent(1.0)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailVC = segue.destination as? PokemonDetailVC {
                if let pokemon = sender as? Pokemon {
                    detailVC.pokemon = pokemon
                }
            }
        }
    }
}


// MARK: - Collection View Data Source and Delegate
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokemon: Pokemon!
            
            if inSearchMode {
                pokemon = filteredPokemons[indexPath.row]
            } else {
                pokemon = pokemons[indexPath.row]
            }
            
            cell.configureCell(pokemon)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemons.count
        } else {
            return pokemons.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon: Pokemon!
        if inSearchMode {
            pokemon = filteredPokemons[indexPath.row]
        } else {
            pokemon = pokemons[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: pokemon)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return ITEM_SIZE
    }
}

// MARK: - Search Bar Delegate
extension MainViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            self.inSearchMode = false
            self.collectionView.reloadData()
            view.endEditing(true)
            
        } else {
            self.inSearchMode = true
            let lower = searchText.lowercased().capitalized
            self.filteredPokemons = self.pokemons.filter({($0.name.range(of: lower) != nil)})
            self.collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
