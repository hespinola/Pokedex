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
    private var _spcAtk: Int!
    private var _spcDef: Int!
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
    
    var spcAtk: Int {
        get {
            if _spcAtk == nil {
                return 0
            } else {
                return _spcAtk
            }
        } set {
            self._spcAtk = newValue
        }
    }
    
    var spcDef: Int {
        get {
            if _spcDef == nil {
                return 0
            } else {
                return _spcDef
            }
        } set {
            self._spcDef = newValue
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
    
    func downloadData(completed: downloadComplete) {
        let url = "\(BASE_URL)\(POKEMON_REQUEST)\(self.id)/"
        print(url)
        
        Alamofire.request(url, withMethod: .get).responseJSON { response in
            let dict = response.result.value! as? Dictionary<String, AnyObject>
            
            if let hp = dict?["hp"] as? Int {
                self.hp = hp
            }
            
            if let attack = dict?["attack"] as? Int {
                self.attack = attack
            }
            
            if let defense = dict?["defense"] as? Int {
                self.defense = defense
            }
            
            if let spAtk = dict?["sp_atk"] as? Int {
                self.spcAtk = spAtk
            }
            
            if let spDef = dict?["sp_def"] as? Int {
                self.spcDef = spDef
            }
            
            if let speed = dict?["speed"] as? Int {
                self.speed = speed
            }
            
            if let types = dict?["types"] as? [Dictionary<String, AnyObject>] , types.count > 0 {
                var type = ""
                
                if let type1 = types[0]["name"] as? String {
                    type = type1.capitalized
                }
                
                if types.count > 1 {
                    if let type2 = types[1]["name"] as? String {
                        type = "\(type)/\(type2.capitalized)"
                    }
                }
                
                self.type = type
            }
            
            // Description
            if let descriptions = dict?["descriptions"] as? [Dictionary<String, AnyObject>] {
                if let descUrl = descriptions[0]["resource_uri"] as? String {
                    
                    Alamofire.request("\(BASE_URL)\(descUrl)", withMethod: .get).responseJSON { response in
                        
                        let descDict = response.result.value as? Dictionary<String, AnyObject>
                        
                        if let description = descDict?["description"] as? String {
                            self.description = description
                        }
                    }
                    completed()
                }
            }
        }
        
        completed()
    }
}
