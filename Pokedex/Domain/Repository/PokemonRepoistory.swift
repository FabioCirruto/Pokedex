//
//  PokemonRepoistory.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 14/05/24.
//

import Foundation

protocol PokemonRepoistory {
    func getPokemonList(limit: Int, offset: Int) async throws -> List
    
    func getPokemon(url: String) async throws -> Pokemon
    
    func searchPokemon(text: String) async throws -> Pokemon
}
