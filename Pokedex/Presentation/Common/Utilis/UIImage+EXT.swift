//
//  UIImage+EXT.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 16/05/24.
//

import UIKit

extension UIImage {
    static func fromUrl(url: String) async -> UIImage? {
        do {
            if let url = URL(string: url)  {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    return image
                } else {
                    return nil
                }
            } else {
                return nil
            }
        } catch (let error) {
            print(error.localizedDescription)
            return nil
        }
    }
}
