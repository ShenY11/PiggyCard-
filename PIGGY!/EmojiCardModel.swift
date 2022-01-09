//
//  EmojiCardModel.swift
//  PIGGY!
//
//  Created by 沈钰婷 on 2021/12/23.
//

import SwiftUI

class EmojiCardModel: ObservableObject { // "ObservableObject" constrainer
    private static func CardModelCreation() -> CardModel<String> {
        let emojiArray: Array<String> = ["🐽","🐷","🐰","🦊"].shuffled()
        return CardModel<String>(ANumOfPairs: emojiArray.count, cardContentFactory: {(pairIndex: Int) -> String in
            emojiArray[pairIndex]
        })
    }
    
    @Published var EmojiCardModel: CardModel<String> = CardModelCreation() //"@Published" a property wrapper
    
    //MARK: access to model
    var cards: Array<CardModel<String>.Card> {
        EmojiCardModel.cards
    }
    
    var selectedCard: CardModel<String>.Card = CardModel<String>.Card(isFaceUp: true, isMatched: false, content: "", id: -1, correspondingID: -1)
    
    //MARK: functions
    func choose(card: CardModel<String>.Card) {
        // matching
        if !(selectedCard.isMatched || card.isMatched) {
            if (selectedCard.id == -1 || selectedCard.content == "" || selectedCard.correspondingID == -1) {
                selectedCard = card
                EmojiCardModel.chooseAnimation(card: selectedCard)
                //MARK: animation starts
                
            } else {
                if (selectedCard.correspondingID != card.id) {
                    EmojiCardModel.chooseAnimationCancel(card: selectedCard)
                    //MARK: animation ends
                    selectedCard.id = -1
                    selectedCard.correspondingID = -1
                    selectedCard.content = ""
                } else {
                    print("A MATCH!")
                    EmojiCardModel.flipCard(card: card)
                    EmojiCardModel.flipCard(card: selectedCard)
                    //MARK: animation ends
                    setMatched(card1: card, card2: selectedCard)
                    selectedCard.id = -1
                    selectedCard.correspondingID = -1
                    selectedCard.content = ""
                }
            }
        }
    }
    
    func setMatched(card1: CardModel<String>.Card, card2: CardModel<String>.Card) {
        EmojiCardModel.setMatched(card1: card1, card2: card2)
    }
}
