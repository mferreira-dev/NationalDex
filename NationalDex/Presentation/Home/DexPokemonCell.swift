//
//  PokemonCell.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/5/22.
//

import Foundation
import UIKit

class DexPokemonCell: UITableViewCell {
	
	let cellView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 20
		view.backgroundColor = .lightGray
		return view
	}()
	
	let iconImageView: UIImageView = {
		return UIImageView()
	}()
	
	let nameLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		return label
	}()
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}
	
	// TODO: Fix constraints.
	func setupView() {
		addSubview(cellView)
		
		[iconImageView, nameLabel].forEach {
			cellView.addSubview($0)
		}
		
		cellView.anchor(
			top: self.topAnchor,
			bottom: self.bottomAnchor,
			leading: self.leadingAnchor,
			trailling: self.trailingAnchor,
			padding: .init(top: 0, left: 10, bottom: 10, right: 10)
		)
		
		iconImageView.anchor(
			top: cellView.topAnchor,
			bottom: cellView.bottomAnchor,
			leading: cellView.leadingAnchor,
			trailling: nil,
			size: .init(width: 128, height: 128)
		)
		
		nameLabel.anchor(
			top: cellView.topAnchor,
			bottom: cellView.bottomAnchor,
			leading: iconImageView.trailingAnchor,
			trailling: cellView.trailingAnchor
		)
	}
	
}
