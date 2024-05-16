//
//  PokemonServiceImpl.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 14/05/24.
//

import Foundation

class PokemonServiceImpl: PokemonService {
    
    func getPokemonList(limit: Int, offset: Int) async throws -> ListDto {
        return try await RequestProvider.shared.request(source: EndPoint.List(limit, offset), of: ListDto.self)
    }
    
    func getPokemon(url: String) async throws -> PokemonDto {
        return try await RequestProvider.shared.request(source: .Detail(url), of: PokemonDto.self)
    }
    
    func getPokemonDesc(url: String) async throws -> PokemonDescDto {
        return try await RequestProvider.shared.request(source: .Desc(url), of: PokemonDescDto.self)
    }
    
    func searchPokemon(text: String) async throws -> PokemonDto {
        return try await RequestProvider.shared.request(source: .Search(text), of: PokemonDto.self)
    }
}
