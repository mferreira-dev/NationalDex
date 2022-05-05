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
	
	var pokemonIndex = [PokemonIndex.Result]()
	var isPaginating = false
	private var offset = 0
	private var count = 0
	
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
			
			safeResponse.results.forEach {
				self.pokemonIndex.append($0)
			}
			
			// TODO: Implement Async network calls.
			self.getPokemonDetails()
			self.pokemonIndex.removeAll()
			
			self.offset += K.pokemonPerPage
			self.isPaginating = false
		}
	}
	
	func getPokemonDetails() {
		pokemonIndex.forEach { it in
			fetchPokemonDetailsByName(name: it.name)
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
			
			self.pokemonListObservable.value = self.pokemonList
		}
	}
	
}
