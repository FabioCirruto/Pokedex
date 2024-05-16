//
//  PokemonUseCase.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 14/05/24.
//

import Foundation
import Factory

class PokemonUseCase {
    @Injected(\.pokemonRepository) private var repository
    
    func getPokemonList(limit: Int, offset: Int) async throws -> List {
        return try await repository.getPokemonList(limit: limit, offset: offset)
    }
    
    func getPokemon(url: String) async throws -> Pokemon {
        return try await repository.getPokemon(url: url)
    }
    
    func searchPokemon(text: String) async throws -> Pokemon {
        return try await repository.searchPokemon(text: text)
    }
}
