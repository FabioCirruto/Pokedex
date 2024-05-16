//
//  ListDto.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 14/05/24.
//

import Foundation
class ListDto: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [PokemonInfoDto]?
}
