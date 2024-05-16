//
//  String+EXT.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 16/05/24.
//

import Foundation

extension String {
    var apiFormatted: String {
        self.replacingOccurrences(of: "\n", with: " ")
    }
}
