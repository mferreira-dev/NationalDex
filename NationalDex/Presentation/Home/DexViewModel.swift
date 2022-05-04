//
//  HomeViewModel.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/4/22.
//

import Foundation

final class DexViewModel {
	
	var isPaginating = false
	
	let pokemonUseCase = PokemonUseCase(PokemonRepositoryImpl.instance)
	
	var pokemonIndexObservable: Observable<[PokemonIndex.Result]> = Observable(nil)
	var pokemonIndex = [PokemonIndex.Result]()
	var offset = 0
	
	init() {
		fetchPokemonIndex()
	}
	
	func fetchPokemonIndex() {
		isPaginating = true
		
		pokemonUseCase.fetchPokemonIndex(pokemonPerPage: K.pokemonPerPage, offset: offset) { response, error in
			if let safeError = error {
				print(safeError.errorDescription!)
				return
			}
			
			response?.results?.forEach {
				self.pokemonIndex.append($0)
			}
			
			self.pokemonIndexObservable.value = self.pokemonIndex
			self.offset += K.pokemonPerPage
			self.isPaginating = false
		}
	}
	
}
