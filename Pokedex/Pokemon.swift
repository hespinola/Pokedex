//
//  Pokemon.swift
//  Pokedex
//
//  Created by Isomi on 9/4/16.
//  Copyright © 2016 Isomi. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _id: Int!
    private var _attack: Int!
    private var _defense: Int!
    private var _specialAttack: Int!
    private var _specialDefense: Int!
    private var _speed: Int!
    private var _hp: Int!
    private var _type: String!
    private var _description: String!
    
    var hp: Int {
        get {
            if _hp == nil {
                return 0
            } else {
                return _hp
            }
        } set {
            self._hp = newValue
        }
    }
    
    var type: String {
        get {
            if _type == nil {
                return ""
            } else {
                return _type
            }
        } set {
            self._type = newValue
        }
    }
    
    var description: String {
        get {
            if _description == nil {
                return ""
            } else {
                return _description
            }
        } set {
            self._description = newValue
        }
    }
    
    var specialAttack: Int {
        get {
            if _specialAttack == nil {
                return 0
            } else {
                return _specialAttack
            }
        } set {
            self._specialAttack = newValue
        }
    }
    
    var specialDefense: Int {
        get {
            if _specialDefense == nil {
                return 0
            } else {
                return _specialDefense
            }
        } set {
            self._specialDefense = newValue
        }
    }
    
    var speed: Int {
        get {
            if _speed == nil {
                return 0
            } else {
                return _speed
            }
        } set {
            self._speed = newValue
        }
    }
    
    var defense: Int {
        get {
            if _defense == nil {
                return 0
            } else {
                return _defense
            }
        } set {
            self._defense = newValue
        }
    }
    
    var attack: Int {
        get {
            if _attack == nil {
                return 0
            } else {
                return _attack
            }
        } set {
            self._attack = newValue
        }
    }
    
    var name: String {
        return _name
    }
    
    var id: Int {
        return _id
    }
    
    init(name: String, id: Int) {
        self._name = name.capitalized
        self._id = id
    }
    
    func downloadData(completion: @escaping() -> Void) {
        let url = "\(BASE_URL)\(POKEMON_REQUEST)\(self.id)/"
        
        Alamofire.request(url, method: .get).responseJSON(completionHandler: { (response) in
            if let dict = response.result.value! as? Dictionary<String, AnyObject> {
                
                if let types = dict["types"] as? [Dictionary<String, AnyObject>] {
                    
                    var typeName = ""
                    
                    for type in types {
                        
                        if let slot = type["slot"] as? Int {
                            
                            if slot == 1 {
                                if let typeValue = type["type"]?["name"] as? String {
                                    typeName = typeValue.capitalized + typeName
                                }
                                
                            } else {
                                if let typeValue = type["type"]?["name"] as? String {
                                    typeName = typeName + "/" + typeValue.capitalized
                                }
                            }
                        }
                    }
                    
                    self.type = typeName
                }
                
                if let stats = dict["stats"] as? [Dictionary<String, AnyObject>] {
                    
                    for stat in stats {
                        
                        if let statType = stat["stat"]?["name"] as? String {
                            
                            switch statType {
                                
                                case "speed":
                                    if let baseStat = stat["base_stat"] as? Int {
                                        self.speed = baseStat
                                    }
                                    break;
                                
                                case "special-defense":
                                    if let baseStat = stat["base_stat"] as? Int {
                                        self.specialDefense = baseStat
                                    }
                                    break;
                                
                                case "special-attack":
                                    if let baseStat = stat["base_stat"] as? Int {
                                        self.specialAttack = baseStat
                                    }
                                    break;
                                
                                case "defense":
                                    if let baseStat = stat["base_stat"] as? Int {
                                        self.defense = baseStat
                                    }
                                    break;
                                
                                case "attack":
                                    if let baseStat = stat["base_stat"] as? Int {
                                        self.attack = baseStat
                                    }
                                    break;
                                
                                case "hp":
                                    if let baseStat = stat["base_stat"] as? Int {
                                        self.hp = baseStat
                                    }
                                    break;
                                
                                default:
                                    // Do nothing
                                    break;
                            }
                        }
                    }
                }
            }
            
            completion()
        })
    }
}
