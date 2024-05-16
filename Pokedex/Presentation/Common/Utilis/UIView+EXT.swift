//
//  UIView+EXT.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 15/05/24.
//

import UIKit

extension UIView {
    static var reusableIdentifer: String {
        get {
            return String(describing: self)
        }
    }
}
