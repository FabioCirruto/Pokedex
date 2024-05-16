//
//  PokemonDataSource.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 14/05/24.
//

import Foundation

protocol PokemonDataSource {
    func getPokemonList(limit: Int, offset: Int) async throws -> ListDto
    
    func getPokemon(url: String) async throws -> PokemonDto
    
    func getPokemonDesc(url: String) async throws -> PokemonDescDto
    
    func searchPokemon(text: String) async throws -> PokemonDto
}
