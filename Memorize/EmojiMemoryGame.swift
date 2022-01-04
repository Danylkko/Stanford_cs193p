//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Danylo Litvinchuk on 14.12.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    // 24 elements
    private static let emojisVehicles = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛",
                         "🚜", "🛵", "🏍", "🛺", "🚅", "🚂", "🛩", "🚀", "🚁", "🛳", "🛰", "🛸"]
    // 17 elements
    private static let emojisPets = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮",
                              "🐷", "🐸", "🐵", "🐣", "🦄"]
    // 22 elements
    private static let emojisMeal = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑",
                           "🥭", "🍍", "🥥", "🥝", "🍆", "🥑", "🥩", "🍔", "🍕", "🍣"]
    // 17 elements
    private static let emojisFaces = ["😃", "😁", "😅", "😂", "😇", "😍", "🥰", "😘", "🤪", "🤩", "🥳", "😏",
                        "🥺", "😭", "🤯", "🥵", "🤮"]
    // 12 elements
    private static let emojisHearts = ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍", "🤎", "💔", "💖", "💘"]
    
    // 12 elements
    private static let emojisZodiac = ["♈️", "♉️", "♊️", "♋️", "♌️", "♍️", "♎️", "♏️", "♐️", "♑️", "♒️", "♓️"]

    private static func createNewTheme<T: Equatable>(themeName: String, numberOfPairs: Int, items: [T], color: Color) -> Theme<T>{
        Theme<T>(themeName: themeName, numberOfPairs: numberOfPairs, items: items, themeColor: color)
    }
    
    private static func createMemoryGame<T>(theme: Theme<T>) -> MemoryGame<T> {
        return MemoryGame<T>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            theme.items[pairIndex]
        }
    }
    
    private static let themesWithEmojies = [
        createNewTheme(themeName: "Vehicles", numberOfPairs: 3, items: emojisVehicles, color: .blue),
        createNewTheme(themeName: "Pets", numberOfPairs: 3, items: emojisPets, color: .orange),
        createNewTheme(themeName: "Fruits&Vegetables", numberOfPairs: 3, items: emojisMeal, color: .green),
        createNewTheme(themeName: "Faces", numberOfPairs: 3, items: emojisFaces, color: .yellow),
        createNewTheme(themeName: "Hearts", numberOfPairs: 3, items: emojisHearts, color: .gray),
        createNewTheme(themeName: "Zodiacs", numberOfPairs: 3, items: emojisZodiac, color: .purple),
        createNewTheme(themeName: "Currency", numberOfPairs: 3, items: ["$", "€", "€"], color: .purple)]
    
    @Published private var model: MemoryGame<String>
    
    private(set) var theme: Theme<String>
    
    init() {
        theme = EmojiMemoryGame.themesWithEmojies.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    func changeTheme() {
        theme = EmojiMemoryGame.themesWithEmojies.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    var themeName: String {
        theme.themeName
    }
    
    var themeColor: Color {
        theme.themeColor
    }
    
    var cards: [Card] {
        return model.cards
    }
    
    func choose(_ card: Card) {
        //objectWillChange.send()
        model.choose(card)
    }
    
    var score: Int {
        return model.score
    }
}
