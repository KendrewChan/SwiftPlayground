//: Playground - noun: a place where people can play

import UIKit

// nest supporting enumerations, classes, and structures within the definition of the type they support

struct BlackJackCard {
    enum Suit: Character { // nested Suit enumeration
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }

    enum Rank: Int { // nested Rank enumeration
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values { // further nested structure
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second { // optional binding to check for second value
            output += " or \(second)"
        }
        return output
    }
}

let theAceOfSpades = BlackJackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")

// Referring to Nested Types
let heartsSymbol = BlackJackCard.Suit.hearts.rawValue
// Use dot syntax prefix to use a nested type outside of its definition context(instance)
