//
//  ViewController.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/4/22.
//

import UIKit
import Kingfisher

class DexViewController: UIViewController, BaseViewController {
	
	private let viewModel = DexViewModel()
	
	private var pokemonCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		return UICollectionView(frame: .zero, collectionViewLayout: layout)
	}()
	
	private var scrollToTopButton: UIButton = {
		let button = UIButton()
		
		button.layer.masksToBounds = true
		button.layer.cornerRadius = 30
		
		button.backgroundColor = .systemPink
		button.setImage(UIImage(systemName: "arrow.up"), for: .normal)
		button.tintColor = .white
		
		return button
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
		
		pokemonCollectionView.register(DexPokemonCell.self, forCellWithReuseIdentifier: K.Cells.pokemonCell)
		pokemonCollectionView.dataSource = self
		pokemonCollectionView.delegate = self
		
		[pokemonCollectionView, scrollToTopButton].forEach {
			view.addSubview($0)
		}
		
		pokemonCollectionView.anchor(
			top: view.safeAreaLayoutGuide.topAnchor,
			bottom: view.safeAreaLayoutGuide.bottomAnchor,
			leading: view.leadingAnchor,
			trailling: view.trailingAnchor,
			padding: .init(top: 0, left: 16, bottom: 0, right: 16)
		)
		
		scrollToTopButton.anchor(
			top: nil,
			bottom: view.safeAreaLayoutGuide.bottomAnchor,
			leading: nil,
			trailling: view.safeAreaLayoutGuide.trailingAnchor,
			padding: .init(top: 0, left: 0, bottom: 16, right: 16),
			size: .init(width: 60, height: 60)
		)
		
		scrollToTopButton.addTarget(self, action: #selector(didTapScrollToTopButton), for: .touchUpInside)
	}
	
	func setupObservers() {
		viewModel.pokemonListObservable.bind { it in
			self.pokemonCollectionView.reloadData()
		}
	}
	
	@objc func didTapScrollToTopButton() {
		self.pokemonCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
	}
	
}

extension DexViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let position = scrollView.contentOffset.y
		
		if (position > pokemonCollectionView.contentSize.height - scrollView.frame.size.height - 1500) {
			if !viewModel.isPaginating {
				viewModel.fetchPokemonIndex()
			}
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let cellsPerRow = 2
		let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
		
		let totalSpace = flowLayout.sectionInset.left
		+ flowLayout.sectionInset.right
		+ (flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1))
		
		let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(cellsPerRow))
		
		return CGSize(width: size, height: size)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Cells.pokemonCell, for: indexPath) as! DexPokemonCell
		
		let name = viewModel.pokemonList[indexPath.row].name.capitalized
		let imageUrl = viewModel.pokemonList[indexPath.row].sprites.other.officialArtwork.frontDefault
		let types = viewModel.pokemonList[indexPath.row].types
		let type1 = types.first?.type.name.capitalized
		let type2 = viewModel.pokemonList[indexPath.row].types.count > 1 ? types.last?.type.name.capitalized : String.empty()
		
		cell.nameLabel.text = name
		cell.iconImageView.kf.setImage(with: URL(string: imageUrl))
		cell.contentView.backgroundColor = UIColor(named: type1?.capitalized ?? String.empty())
		cell.type1Label.text = type1
		cell.type2Label.text = type2
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.pokemonList.count
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print(viewModel.pokemonList[indexPath.row].name)
	}
	
}
