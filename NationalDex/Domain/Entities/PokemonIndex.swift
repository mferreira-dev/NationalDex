//
//  Pokemon.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/4/22.
//

import Foundation

struct PokemonIndex: Decodable {
	
	let count: Int
	let next: String?
	let previous: String?
	let results: [Result]?
	
	struct Result: Decodable {
		let name: String?
		let url: String?
	}
	
}
