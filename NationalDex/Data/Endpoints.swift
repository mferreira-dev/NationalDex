//
//  Endpoints.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/4/22.
//

import Foundation

struct Endpoints {
	
	static func getPokemonIndexUrl(limit: Int, offset: Int) -> String {
		return "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
	}
	
}
