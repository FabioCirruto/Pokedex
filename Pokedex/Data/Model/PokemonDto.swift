//
//  PokemonDto.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 14/05/24.
//

import Foundation

class PokemonDto: Codable {
    var name: String?
    var sprites: ImagesDto?
    var types: [TypeDto]?
    var species: SpeciesInfoDto?
}

class TypesDto: Codable {
    var name: String?
    var url: String?
}

class ImagesDto: Codable {
    var frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

class SpeciesInfoDto: Codable {
    var name: String?
    var url: String?
}

struct TypeDto: Codable {
    let slot: Int
    let type: PokemonTypeDto
}

struct PokemonTypeDto: Codable {
    let name: String
    let url: String
}

