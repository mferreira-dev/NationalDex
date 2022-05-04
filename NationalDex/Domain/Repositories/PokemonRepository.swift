//
//  PokemonIndexRepository.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/4/22.
//

import Foundation
import Alamofire

protocol PokemonRepository {
	func fetchPokemonIndex(pokemonPerPage: Int, offset: Int, completion: @escaping (PokemonIndex?, AFError?) -> Void)
}
