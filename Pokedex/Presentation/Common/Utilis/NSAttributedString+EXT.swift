//
//  NSAttributedString+EXT.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 16/05/24.
//

import UIKit

extension NSAttributedString {
    
    static func build(strings: [String], fonts: [UIFont], colors: [UIColor]) -> NSMutableAttributedString {
        let mutabableString = NSMutableAttributedString()
        guard strings.count <= fonts.count, strings.count <= colors.count else { return NSMutableAttributedString() }
        strings.enumerated().forEach { (index, string) in
            mutabableString.append(NSAttributedString(string: string, attributes: [NSAttributedString.Key.font: fonts[index], NSAttributedString.Key.foregroundColor : colors[index]]))
        }
        
        return mutabableString
    }
}
