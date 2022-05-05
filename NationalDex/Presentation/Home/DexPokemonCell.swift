//
//  PokemonCell.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/5/22.
//

import Foundation
import UIKit

class DexPokemonCell: UICollectionViewCell {
	
	let iconImageView: UIImageView = {
		return UIImageView()
	}()
	
	let nameLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		return label
	}()
	
	let type1Label: UILabel = {
		let label = UILabel()
		label.textColor = .white
		return label
	}()
	
	let type2Label: UILabel = {
		let label = UILabel()
		label.textColor = .white
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	func setupView() {
		contentView.layer.cornerRadius = 15
		contentView.clipsToBounds = true
		
		[iconImageView, nameLabel, type1Label, type2Label].forEach {
			contentView.addSubview($0)
		}
		
		iconImageView.anchor(
			top: nil,
			bottom: contentView.bottomAnchor,
			leading: nil,
			trailling: contentView.trailingAnchor,
			padding: .init(top: 0, left: 0, bottom: 8, right: 8),
			size: .init(width: 128, height: 128)
		)
		
		nameLabel.anchor(
			top: contentView.topAnchor,
			bottom: nil,
			leading: contentView.leadingAnchor,
			trailling: contentView.trailingAnchor,
			padding: .init(top: 16, left: 16, bottom: 0, right: 16)
		)
		
		type1Label.anchor(
			top: nameLabel.bottomAnchor,
			bottom: nil,
			leading: nameLabel.leadingAnchor,
			trailling: nil
		)
		
		type2Label.anchor(
			top: type1Label.bottomAnchor,
			bottom: nil,
			leading: nameLabel.leadingAnchor,
			trailling: nil
		)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
