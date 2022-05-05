//
//  PokemonDetails.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/5/22.
//

import Foundation

struct PokemonDetails: Decodable {
	
	let abilities: [Ability]
	let forms: [Form]
	let height: Int
	let weight: Int
	let id: Int
	let encounters: String
	let moves: [Move]
	let name: String
	let sprites: Sprites
	let stats: [Stat]
	let types: [PokemonType]
	
	struct Ability: Decodable {
		let ability: SubAbility
		let isHidden: Bool
		
		struct SubAbility: Decodable {
			let name: String
			let url: String
		}
		
		enum CodingKeys: String, CodingKey {
			case ability = "ability"
			case isHidden = "is_hidden"
		}
	}
	
	struct Form: Decodable {
		let name: String
		let url: String
	}
	
	struct Move: Decodable {
		let move: SubMove
		let versionGroupDetails: [VersionGroupDetails]
		
		struct SubMove: Decodable {
			let name: String
			let url: String
		}
		
		struct VersionGroupDetails: Decodable {
			let levelLearnedAt: Int
			let moveLearnMethod: MoveLearnMethod
			let versionGroup: VersionGroup
			
			struct MoveLearnMethod: Decodable {
				let name: String
				let url: String
			}
			
			struct VersionGroup: Decodable {
				let name: String
				let url: String
			}
			
			enum CodingKeys: String, CodingKey {
				case levelLearnedAt = "level_learned_at"
				case moveLearnMethod = "move_learn_method"
				case versionGroup = "version_group"
			}
		}
		
		enum CodingKeys: String, CodingKey {
			case move = "move"
			case versionGroupDetails = "version_group_details"
		}
	}
	
	struct Sprites: Decodable {
		let frontDefault: String
		let other: Other
		let versions: Versions
		
		struct Other: Decodable {
			let home: Home
			let officialArtwork: OfficialArtwork
			
			struct Home: Decodable {
				var frontDefault: String? = String.empty()
				
				enum CodingKeys: String, CodingKey {
					case frontDefault = "front_default"
				}
			}
			
			struct OfficialArtwork: Decodable {
				let frontDefault: String
				
				enum CodingKeys: String, CodingKey {
					case frontDefault = "front_default"
				}
			}
			
			enum CodingKeys: String, CodingKey {
				case home = "home"
				case officialArtwork = "official-artwork"
			}
		}
		
		struct Versions: Decodable {
			let gen8: Gen8
			
			struct Gen8: Decodable {
				let icons: Icons
				
				struct Icons: Decodable {
					var frontDefault: String? = String.empty()
					
					enum CodingKeys: String, CodingKey {
						case frontDefault = "front_default"
					}
				}
			}
			
			enum CodingKeys: String, CodingKey {
				case gen8 = "generation-viii"
			}
		}
		
		enum CodingKeys: String, CodingKey {
			case frontDefault = "front_default"
			case other = "other"
			case versions = "versions"
		}
	}
	
	struct Stat: Decodable {
		let baseStat: Int
		let effort: Int
		let stat: SubStat
		
		struct SubStat: Decodable {
			let name: String
			let url: String
		}
		
		enum CodingKeys: String, CodingKey {
			case baseStat = "base_stat"
			case effort = "effort"
			case stat = "stat"
		}
	}
	
	struct PokemonType: Decodable {
		let slot: Int
		let type: SubPokemonType
		
		struct SubPokemonType: Decodable {
			let name: String
			let url: String
		}
	}
	
	enum CodingKeys: String, CodingKey {
		case abilities = "abilities"
		case forms = "forms"
		case height = "height"
		case weight = "weight"
		case id = "id"
		case encounters = "location_area_encounters"
		case moves = "moves"
		case name = "name"
		case sprites = "sprites"
		case stats = "stats"
		case types = "types"
	}
	
}
