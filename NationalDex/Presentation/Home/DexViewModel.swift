//
//  HomeViewModel.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/4/22.
//

import Foundation

final class DexViewModel {
	
	let pokemonUseCase = PokemonUseCase(PokemonRepositoryImpl.instance)
	
	var pokemonIndexObservable: Observable<[PokemonIndex.Result]> = Observable(nil)
	var pokemonIndex = [PokemonIndex.Result]()
	
	var isPaginating = false
	private var offset = 0
	private var count = 0
	
	init() {
		fetchPokemonIndex()
	}
	
	func fetchPokemonIndex() {
		if offset > count {
			return
		}
		
		isPaginating = true
		
		pokemonUseCase.fetchPokemonIndex(pokemonPerPage: K.pokemonPerPage, offset: offset) { response, error in
			if let safeError = error {
				print(safeError.errorDescription!)
				return
			}
			
			guard let safeResponse = response else { return }
			
			if self.count == 0 {
				self.count = safeResponse.count
			}
			
			safeResponse.results.forEach {
				self.pokemonIndex.append($0)
			}
			
			self.pokemonIndexObservable.value = self.pokemonIndex
			self.offset += K.pokemonPerPage
			self.isPaginating = false
		}
	}
	
}
