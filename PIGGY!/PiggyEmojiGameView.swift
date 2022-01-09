//
//  PiggyEmojiGameView.swift
//  PIGGY!
//
//  Created by 沈钰婷 on 2021/12/22.
//

import SwiftUI

struct PiggyEmojiGameView: View {
    @ObservedObject var viewModel: EmojiCardModel
    var body: some View {
        let numOfPairs: Int = viewModel.EmojiCardModel.numOfPairs
        VStack() {
            let rolNum: Int = 2
            ForEach(0..<rolNum) { index1 in
                HStack() {
                    ForEach (0..<numOfPairs) { index2 in
                        let card: CardModel.Card = viewModel.cards[index1 * numOfPairs + index2]
                        CardView(card: card).onTapGesture(perform: {
                            viewModel.choose(card: card)
                        })
                    }
                }
                    //.padding()
            }
        }
        //.padding()
    }
}

struct CardView: View {
    var card: CardModel<String>.Card
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        if card.isFaceUp {
            ZStack {
                RoundedRectangle(cornerRadius: 5).stroke(Color.pink, lineWidth: 8)
                RoundedRectangle(cornerRadius: 5).fill(colorScheme == .dark ? Color.black:Color.white)
                Text(card.content)
                    .opacity(card.hasChooseAnimation ? 0 : 1)
                        .animation(
                            Animation.linear
                                .repeatCount(card.hasChooseAnimation ? Int.max : 0, autoreverses: true)
                            .speed(0.4))
                        .font(Font.largeTitle)
            }
            .padding()
            .frame(width: 80, height: 320)
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 5).fill(colorScheme == .dark ? Color.black:Color.white)
            }
            .padding()
            .frame(width: 80, height: 320)
        }
        
        //.padding()
        //.foregroundColor(Color.white)
        //.font(Font.largeTitle)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PiggyEmojiGameView(viewModel: EmojiCardModel())
    }
}
