//
//  PokemonUseCase.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/4/22.
//

import Foundation
import Alamofire

final class PokemonUseCase {
	
	private let pokemonRepository: PokemonRepository
	
	init(_ pokemonRepository: PokemonRepository) {
		self.pokemonRepository = pokemonRepository
	}
	
	func fetchPokemonIndex(pokemonPerPage: Int, offset: Int, completion: @escaping (PokemonIndex?, AFError?) -> Void) {
		pokemonRepository.fetchPokemonIndex(pokemonPerPage: pokemonPerPage, offset: offset, completion: completion)
	}
	
}
