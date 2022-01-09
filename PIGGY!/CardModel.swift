//
//  CardModel.swift
//  PIGGY!
//
//  Created by 沈钰婷 on 2021/12/23.
//

import Foundation
import SwiftUI

struct CardModel<CardContentType> {
    private(set) var cards: Array<Card>
    private(set) var upRollCards: Array<Card>
    private(set) var downRollCards: Array<Card>
    var numOfPairs: Int
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContentType
        var id: Int
        var correspondingID: Int
        
        var hasChooseAnimation: Bool = false
    }
    
    init(ANumOfPairs: Int, cardContentFactory: (Int) -> CardContentType) {
        cards = Array<Card>()
        upRollCards = Array<Card>()
        downRollCards = Array<Card>()
        numOfPairs = ANumOfPairs
        for pairIndex in (0..<numOfPairs) {
            let acardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: acardContent, id: pairIndex, correspondingID: -1))
        }
        let rolNum: Int = 2
        for i in (0..<rolNum-1) {
            for j in (0..<numOfPairs) {
                var acard = cards[j]
                acard.id = acard.id + (1+i) * numOfPairs
                acard.correspondingID = cards[j].id
                cards[j].correspondingID = acard.id
                cards.append(acard)
            }
        }
        cards.shuffle()
    }
    
    mutating func chooseAnimation(card: Card) -> () {
        //TODO: Animation for choosing
        let chosenCardIndex: Int = self.index(of: card)
        self.cards[chosenCardIndex].hasChooseAnimation = true
    }
    mutating func chooseAnimationCancel(card: Card) -> () {
        //TODO: Cancel animation for choosing
        let chosenCardIndex: Int = self.index(of: card)
        self.cards[chosenCardIndex].hasChooseAnimation = false
    }
    
    mutating func flipCard(card: Card) {
        print("card: \(card)")
        let chosenCardIndex: Int = self.index(of: card)
        if !card.isMatched {
            self.cards[chosenCardIndex].isFaceUp = !self.cards[chosenCardIndex].isFaceUp
        }
    }
    
    mutating func setMatched(card1: Card, card2: Card) {
        let chosenCardIndex1: Int = self.index(of: card1)
        let chosenCardIndex2: Int = self.index(of: card2)
        self.cards[chosenCardIndex1].isMatched = true
        self.cards[chosenCardIndex2].isMatched = true
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if self.cards[index].id == card.id {
                return index
            }
        }
        return 0
    }
}
