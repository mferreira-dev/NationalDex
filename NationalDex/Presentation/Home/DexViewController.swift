//
//  ViewController.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/4/22.
//

import UIKit
import Kingfisher

class DexViewController: UIViewController, BaseProtocol {
	
	private let viewModel = DexViewModel()
	
	private let pokemonTableView: UITableView = {
		let table = UITableView()
//		table.tableHeaderView = UIView()
		table.separatorStyle = .none
		table.register(DexPokemonCell.self, forCellReuseIdentifier: K.Cells.pokemonCell)
		return table
	}()
	
	override func loadView() {
		super.loadView()
		setupLayout()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupObservers()
	}
	
	func setupLayout() {
		view.backgroundColor = .systemBackground
		
		[pokemonTableView].forEach {
			view.addSubview($0)
		}
		
		pokemonTableView.dataSource = self
		pokemonTableView.delegate = self
		
		pokemonTableView.anchor(
			top: view.safeAreaLayoutGuide.topAnchor,
			bottom: view.safeAreaLayoutGuide.bottomAnchor,
			leading: view.leadingAnchor,
			trailling: view.trailingAnchor
		)
	}
	
	func setupObservers() {
		viewModel.pokemonListObservable.bind { it in
			self.pokemonTableView.reloadData()
		}
	}
	
}

extension DexViewController: UITableViewDelegate, UITableViewDataSource {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let position = scrollView.contentOffset.y
		
		if (position > pokemonTableView.contentSize.height - scrollView.frame.size.height - 1500) {
			if !viewModel.isPaginating {
				viewModel.fetchPokemonIndex()
			}
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.pokemonList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.pokemonCell, for: indexPath) as! DexPokemonCell
		
		let name = viewModel.pokemonList[indexPath.row].name.capitalized
		let imageUrl = viewModel.pokemonList[indexPath.row].sprites.other.officialArtwork.frontDefault
		
		cell.nameLabel.text = name
		cell.iconImageView.kf.setImage(with: URL(string: imageUrl))
		
		return cell
	}
	
}
