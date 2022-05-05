//
//  BaseViewController.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/4/22.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {}

extension UIView {
	
	func anchor(
		top: NSLayoutYAxisAnchor?,
		bottom: NSLayoutYAxisAnchor?,
		leading: NSLayoutXAxisAnchor?,
		trailling: NSLayoutXAxisAnchor?,
		padding: UIEdgeInsets = .zero,
		size: CGSize = .zero
	) {
		
		translatesAutoresizingMaskIntoConstraints = false
		
		if let safeTop = top {
			self.topAnchor.constraint(equalTo: safeTop, constant: padding.top).isActive = true
		}
		
		if let safeBottom = bottom {
			self.bottomAnchor.constraint(equalTo: safeBottom, constant: -padding.bottom).isActive = true
		}
		
		if let safeLeading = leading {
			self.leadingAnchor.constraint(equalTo: safeLeading, constant: padding.left).isActive = true
		}
		
		if let safeTrailling = trailling {
			self.trailingAnchor.constraint(equalTo: safeTrailling, constant: -padding.right).isActive = true
		}
		
		if size.width != 0 {
			self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
		}
		
		if size.height != 0 {
			self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
		}
		
	}
	
	func anchorSize(to view: UIView) {
		widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
	}
	
}
