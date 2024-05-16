//
//  PokemonUI.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 16/05/24.
//

import UIKit

class PokemonUI {
    let name: String
    let desc: String
    let types: [String]
    let image: UIImage?
    
    init(name: String, desc: String, types: [String], image: UIImage?) {
        self.name = name
        self.desc = desc
        self.types = types
        self.image = image
    }
}
