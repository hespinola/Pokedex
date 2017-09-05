//
//  PokeButton.swift
//  Pokedex
//
//  Created by Isomi on 9/5/17.
//  Copyright © 2017 Isomi. All rights reserved.
//

import UIKit

class PokeButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = AppStyles.Color.Main
        tintColor = UIColor.white
        layer.cornerRadius = frame.width * 0.2 // 20 %
        layer.masksToBounds = layer.cornerRadius > 0
    }
}
