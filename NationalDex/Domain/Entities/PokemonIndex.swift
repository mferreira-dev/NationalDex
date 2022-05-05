//
//  Pokemon.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/4/22.
//

import Foundation

struct PokemonIndex: Decodable {
	
	let count: Int
	let results: [Result]
	
	struct Result: Decodable {
		let name: String
		let url: String
	}
	
}
