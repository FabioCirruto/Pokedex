//
//  Pokemon+DI.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 15/05/24.
//

import Foundation
import Factory

extension Container {
    var pokemonRepository: Factory<PokemonRepoistory> {
        Factory(self) { PokemonRepositoryImpl() }
    }
    
    var pokemonService: Factory<PokemonService> {
        Factory(self) { PokemonServiceImpl() }
    }
    
    var pokemonDataSource: Factory<PokemonDataSource> {
        Factory(self) { PokemonDataSourceImpl() }
    }
    
    var pokemonUseCase: Factory<PokemonUseCase> {
        Factory(self) { PokemonUseCase() }
    }
    
    var pokemonViewModel: Factory<PokemonViewModel> {
        Factory(self) { PokemonViewModel() }
    }
}
