//
//  List.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 14/05/24.
//

import Foundation

class List {
    var next: String?
    var results: [PokemonInfo]
    
    init(next: String? = nil, results: [PokemonInfo]) {
        self.next = next
        self.results = results
    }
    
    init(from: ListDto) {
        self.next = from.next
        results = (from.results ?? []).map({PokemonInfo(from: $0)})
    }
}

class PokemonInfo {
    var name: String
    var detail: String
    
    init(name: String, image: String) {
        self.name = name
        self.detail = image
    }
    
    init(from: PokemonInfoDto) {
        self.name = from.name ?? ""
        self.detail = from.url ?? ""
    }
}
