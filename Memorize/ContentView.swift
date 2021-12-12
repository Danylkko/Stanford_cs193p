//
//  ContentView.swift
//  Memorize
//
//  Created by Danylo Litvinchuk on 12.12.2021.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛",
                  "🚜", "🛵", "🏍", "🛺", "🚅", "🚂", "🛩", "🚀", "🚁", "🛳", "🛰", "🛸"]
    
    @State var emojiCount = 20;
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                        ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                            CardView(content: emoji)
                                .aspectRatio(2/3, contentMode: .fit)
                        }
                    }
                }
                .foregroundColor(.purple)
            }
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
        }
        .padding(.horizontal)
    }
    
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        }
        label: {
            Image(systemName: "minus.square")
        }
    }
    
    var add: some View {
        Button{
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        }
        label: {
            Image(systemName: "plus.app")
        }
    }
}

struct CardView: View {
    
    let content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack(content: {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3.0)
                Text(content).font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            } else {
                shape.fill()
            }
        })
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light)
        ContentView().preferredColorScheme(.dark)
    }
}
