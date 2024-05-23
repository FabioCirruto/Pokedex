//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 15/05/24.
//

import UIKit
import Factory

class PokemonViewModel {
    @Injected(\.pokemonUseCase) private var useCase
    
    var models: [PokemonUI] = []
    private var nextPage: String?
    var canDownloadMore: Bool {
        nextPage != nil && models.count == (perPage * page) && textSearch == nil
    }
    var vcReference: PokemonView?
    
    private let perPage: Int = UIConstant.perPage
    private var page: Int = 0
    private var offSet: Int {
        perPage * page
    }
    private var textSearch: String?
    
    func download() {
        Task {
            await self.getPokemonList()
        }
    }
    
    private func getPokemonList() async {
        nextPage = nil
        do {
            let list = try await useCase.getPokemonList(limit: perPage, offset: offSet)
            self.nextPage = list.next
            self.page += 1
            
            let _ = await withTaskGroup(of: PokemonUI?.self, returning: [PokemonUI?].self) { taskGroup in

                for info in list.results {
                    taskGroup.addTask { await self.getPokemon(info: info) }
                }

                return await taskGroup.reduce(into: [PokemonUI]()) { partialResult, name in
                    if let pokemon = name {
                        self.models.append(pokemon)
                        DispatchQueue.main.async {
                            self.vcReference?.tableView.reloadData()
                        }
                    }
                    partialResult.append(name)
                }
            }
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    private func getPokemon(info: PokemonInfo) async -> PokemonUI? {
        do {
            let pokemon = try await useCase.getPokemon(url: info.detail)
            let image: UIImage? = await UIImage.fromUrl(url: pokemon.image)
            return PokemonUI(
                name: pokemon.name.capitalized,
                desc: pokemon.desc.apiFormatted,
                types: pokemon.types.map {$0.name},
                image: image
            )
        } catch (let error) {
            print(error.localizedDescription)
            return nil
        }
        /*do {
            let pokemon = try await useCase.getPokemon(url: info.detail)
            await prepareModel(pokemon: pokemon)
        } catch (let error) {
            print(error.localizedDescription)
        }*/
    }
    
    private func prepareModel(pokemon: Pokemon) async {
        let image: UIImage? = await UIImage.fromUrl(url: pokemon.image)
        self.models.append(
            PokemonUI(
                name: pokemon.name.capitalized,
                desc: pokemon.desc.apiFormatted,
                types: pokemon.types.map {$0.name},
                image: image
            )
        )
        DispatchQueue.main.async {
            self.vcReference?.tableView.reloadData()
        }
    }
    
    func search(text: String?) {
        if let text = text {
            self.textSearch = text
            nextPage = nil
            page = 0
            cleanTable()
            Task {
                do {
                    let pokemon = try await useCase.searchPokemon(text: text.lowercased())
                    await prepareModel(pokemon: pokemon)
                } catch (let error) {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func delete() {
        if self.textSearch != nil {
            cleanTable()
            download()
            self.textSearch = nil
        }
    }
    
    private func cleanTable() {
        self.models.removeAll()
        self.vcReference?.tableView.reloadData()
    }
}
