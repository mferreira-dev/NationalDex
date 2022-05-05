//
//  NetworkClient.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/4/22.
//

import Foundation
import Alamofire

struct NetworkClient {
	
	static let instance = NetworkClient()
	
	private func perform<T: Decodable>(_ url: String, _ completion: @escaping (T?, AFError?) -> Void) {
		let request = AF.request(url)
		
		request.responseDecodable(of: T.self) { response in
			if let safeError = response.error {
				completion(nil, safeError)
			} else if let safeResponse = response.value {
				completion(safeResponse, nil)
			}
		}
	}
	
	func fetchPokemonIndex(url: String, completion: @escaping (PokemonIndex?, AFError?) -> Void) {
		perform(url, completion)
	}
	
	func fetchPokemonDetailsByName(url: String, completion: @escaping (PokemonDetails?, AFError?) -> Void) {
		perform(url, completion)
	}
	
}
