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
    private static let emojisVehicles = ["๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐",
                         "๐", "๐ต", "๐", "๐บ", "๐", "๐", "๐ฉ", "๐", "๐", "๐ณ", "๐ฐ", "๐ธ"]
    // 17 elements
    private static let emojisPets = ["๐ถ", "๐ฑ", "๐ญ", "๐น", "๐ฐ", "๐ฆ", "๐ป", "๐ผ", "๐จ", "๐ฏ", "๐ฆ", "๐ฎ",
                              "๐ท", "๐ธ", "๐ต", "๐ฃ", "๐ฆ"]
    // 22 elements
    private static let emojisMeal = ["๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐",
                           "๐ฅญ", "๐", "๐ฅฅ", "๐ฅ", "๐", "๐ฅ", "๐ฅฉ", "๐", "๐", "๐ฃ"]
    // 17 elements
    private static let emojisFaces = ["๐", "๐", "๐", "๐", "๐", "๐", "๐ฅฐ", "๐", "๐คช", "๐คฉ", "๐ฅณ", "๐",
                        "๐ฅบ", "๐ญ", "๐คฏ", "๐ฅต", "๐คฎ"]
    // 12 elements
    private static let emojisHearts = ["โค๏ธ", "๐งก", "๐", "๐", "๐", "๐", "๐ค", "๐ค", "๐ค", "๐", "๐", "๐"]
    
    // 12 elements
    private static let emojisZodiac = ["โ๏ธ", "โ๏ธ", "โ๏ธ", "โ๏ธ", "โ๏ธ", "โ๏ธ", "โ๏ธ", "โ๏ธ", "โ๏ธ", "โ๏ธ", "โ๏ธ", "โ๏ธ"]

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
        createNewTheme(themeName: "Currency", numberOfPairs: 3, items: ["$", "โฌ", "โฌ"], color: .purple)]
    
    @Published private var model: MemoryGame<String>
    
    private(set) var theme: Theme<String> = EmojiMemoryGame.getNewTheme()
    
    init() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
        shuffle()
    }
    
    func changeTheme() {
        theme = EmojiMemoryGame.getNewTheme()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    static func getNewTheme() -> Theme<String> {
        EmojiMemoryGame.themesWithEmojies.randomElement()!
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
    
    func shuffle() {
        model.shuffle()
    }
    
    var score: Int {
        return model.score
    }
}
