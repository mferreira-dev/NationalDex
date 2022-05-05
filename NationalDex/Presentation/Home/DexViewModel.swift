//
//  HomeViewModel.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/4/22.
//

import Foundation

final class DexViewModel {
	
	let pokemonUseCase = PokemonUseCase(PokemonRepositoryImpl.instance)
	
	var pokemonListObservable: Observable<[PokemonDetails]> = Observable(nil)
	var pokemonList = [PokemonDetails]()
	
	private let group = DispatchGroup()
	private var offset = 0
	private var count = 0
	
	var isPaginating = false
	
	func fetchPokemonIndex() {
		if offset > count {
			return
		}
		
		isPaginating = true
		
		pokemonUseCase.fetchPokemonIndex(pokemonPerPage: K.pokemonPerPage, offset: offset) { response, error in
			if let safeError = error {
				print(safeError)
				return
			}
			
			guard let safeResponse = response else { return }
			
			if self.count == 0 {
				self.count = safeResponse.count
			}
			
			safeResponse.results.forEach { it in
				self.group.enter()
				self.fetchPokemonDetailsByName(name: it.name)
			}
			
			self.group.notify(queue: .main) {
				self.pokemonList = self.pokemonList.sorted(by: { $0.id < $1.id})
				self.pokemonListObservable.value = self.pokemonList
			}
			
			self.offset += K.pokemonPerPage
			self.isPaginating = false
		}
	}
	
	func fetchPokemonDetailsByName(name: String) {
		pokemonUseCase.fetchPokemonDetailsByName(name: name) { response, error in
			if let safeError = error {
				print(safeError)
				return
			}
			
			guard let safeResponse = response else { return }
			
			self.pokemonList.append(safeResponse)
			self.group.leave()
		}
	}
	
}
