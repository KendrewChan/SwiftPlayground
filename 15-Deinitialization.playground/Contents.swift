//: Playground - noun: a place where people can play

import UIKit

//A deinitiaizer is called immediately before a class instance is deallocated -> written with 'deinit' keyword

//Swift automatically deallocates your instances when they are no longer needed to free up resources


//Class definitions can have at most one deintializer per class
//Deinitializers are called automatically, just before instance deallocation takes place -> you are not allowed to call a deinitializer yourself
// this means deinitializers can't be called with dot syntax like methods(functions)
class test {
    deinit {
        //perform deinitialization
    }
}

//Example of deinitializer in action
class Bank {
    static var coinsInBank = 10_000 //static such that its type cannot be changed to String, Bool, etc
    static func distribute(coins numberOfCoinsRequested: Int) -> Int{
        let numberOfCoinsVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsVend
        return numberOfCoinsVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) { // called when instance is allocated
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse) //calls this just before instance is deallocated
    }
}
var playerOne: Player? = Player(coins: 100) // optional lets you track whether there is currently a player in the game
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
print("There are now \(Bank.coinsInBank) coins left in the bank")

playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
print("The bank now only has \(Bank.coinsInBank) coins left")

playerOne = nil // deallocates instance
print("PlayerOne has left the game")
print("The bank now has \(Bank.coinsInBank) coins") //deinitializer runs to return money back to the bank
