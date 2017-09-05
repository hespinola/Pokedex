//
//  Constants.swift
//  Pokedex
//
//  Created by Isomi on 9/5/16.
//  Copyright © 2016 Isomi. All rights reserved.
//

import UIKit

let APP_NAME = "Pokedex"

let BASE_URL = "http://pokeapi.co"
let POKEMON_REQUEST = "/api/v1/pokemon/"
let MOVEMENT_REQUEST = "/api/v2/pokemon/"

// Adjust font size for iPhone SE
let ITEM_SIZE = UIScreen.main.bounds.width == 320.0 ? CGSize(width: 80, height: 80) : CGSize(width: 105, height: 105)

typealias downloadComplete = () -> ()
