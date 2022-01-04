//
//  GameTheme.swift
//  Memorize
//
//  Created by Danylo Litvinchuk on 15.12.2021.
//

import SwiftUI

struct Theme<CardContent: Equatable> {
    let themeName: String
    let numberOfPairs: Int
    let items: [CardContent]
    let themeColor: Color
    
    init(themeName: String, numberOfPairs: Int, items: [CardContent], themeColor: Color) {
        self.themeName = themeName
        self.items = items.uniqued()
        self.numberOfPairs = min(numberOfPairs, self.items.count)
        self.themeColor = themeColor
    }
}

extension Array where Element: Equatable {
    func uniqued() -> Array {
        var buffer = Array()
        for elem in self {
            if !buffer.contains(elem) {
                buffer.append(elem)
            }
        }
        return buffer
    }
}
