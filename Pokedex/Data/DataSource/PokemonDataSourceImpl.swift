//
//  PokemonDataSourceImpl.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 14/05/24.
//

import Foundation
import Factory

class PokemonDataSourceImpl: PokemonDataSource {
    @Injected(\.pokemonService) private var service
    
    func getPokemonList(limit: Int, offset: Int) async throws -> ListDto {
        return try await service.getPokemonList(limit: limit, offset: offset)
    }
    
    func getPokemon(url: String) async throws -> PokemonDto {
        return try await service.getPokemon(url: url)
    }
    
    func getPokemonDesc(url: String) async throws -> PokemonDescDto {
        return try await service.getPokemonDesc(url: url)
    }
    
    func searchPokemon(text: String) async throws -> PokemonDto {
        return try await service.searchPokemon(text: text)
    }
}
