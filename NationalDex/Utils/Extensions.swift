//
//  Extensions.swift
//  NationalDex
//
//  Created by Martin Ferreira on 5/5/22.
//

import Foundation
import UIKit

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

extension UIColor {
	
	static func colorFromHex(_ hex: String) -> UIColor {
		var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
		
		if (hexString.hasPrefix("#")) {
			hexString.remove(at: hexString.startIndex)
		}
		
		if (hexString.count != 6) {
			return UIColor.black
		}
		
		let r, g, b: CGFloat
		let scanner = Scanner(string: hexString)
		var hexNumber: UInt64 = 0
		
		if scanner.scanHexInt64(&hexNumber) {
			r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
			g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
			b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
			
			return UIColor(.init(red: r, green: g, blue: b))
		}
		
		return UIColor.black
	}
	
}

extension String {
	
	static func empty() -> String {
		return ""
	}
	
}
