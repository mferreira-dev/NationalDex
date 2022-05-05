//
//  PokemonIndexRepositoryImpl.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/4/22.
//

import Foundation
import Alamofire

struct PokemonRepositoryImpl: PokemonRepository {

	static let instance = PokemonRepositoryImpl()
	
	func fetchPokemonIndex(pokemonPerPage: Int, offset: Int, completion: @escaping (PokemonIndex?, AFError?) -> Void) {
		NetworkClient.instance.fetchPokemonIndex(url: Endpoints.getPokemonIndexUrl(limit: pokemonPerPage, offset: offset), completion: completion)
	}

	func fetchPokemonDetailsByName(name: String, completion: @escaping (PokemonDetails?, AFError?) -> Void) {
		NetworkClient.instance.fetchPokemonDetailsByName(url: Endpoints.getPokemonDetailsByNameUrl(name: name), completion: completion)
	}
	
}
