//: Playground - noun: a place where people can play

import UIKit

//Representing and Throwing errors
enum VendingMachineError: Error {
    //errors are represented by values of types that conform to the Error protocol -> empty protocol indicates that a type can be used for error handling
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
    // Imagine the enum error as an array -> each time an error is thrown, it is added to the array -> if the error exists in the array then certain commands can be implemented
}
//Throwing an error lets you indicate that something unexpected happened and the normal flow of execution can’t continue

throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
//throws an error to indicate that five additional coins are needed by the vending machine


//When an error is thrown, some surrounding piece of code must be responsible for handling the error—for example, by correcting the problem, trying an alternative approach, or informing the user of the failure

// Four ways to handle errors in Swift
// 1. propagate the error from a function to the code that calls that function
// 2. handle the error using a do-catch statement
// 3. handle the error as an optional value -> use ?
// 4. assert that the error will not occur -> unwrapping


// Method 1: Propagating Errors Using Throwing Functions
struct Item {
    var price: Int
    var count: Int
}
// A throwing function propagates errors that are thrown inside of it to the scope from which it’s called.
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        // method uses guard statements to exit the method early and throw appropriate errors if any of the requirements for purchasing a snack aren’t met
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        } // reports error if 'item = inventory[name] -> false
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        } // reports error if 'item.count < 0'
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        } // returns coinsNeeded(of type error) when there are insufficient funds
        
        //Because a throw statement immediately transfers program control, an item will be vended only if all of these requirements are me
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name]
        
        print("Dispensing \(name)")
    }
}

let favouriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
//  Because the vend(itemNamed:) method propagates any errors it throws, any code that calls this method must either handle the errors—using a do-catch statement, try?, or try!—or continue to propagate them
func buyFavouriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favouriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
} // since method can throw an error, it’s called with the try keyword in front of it

struct PurchaseSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}


// Method 2: Handling Errors Using Do-Catch
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavouriteSnack(person: "Alice", vendingMachine: vendingMachine)
    // function is called in a try expression, because it can throw an error
    print("Success! Yummy.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of stock")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
    // If no pattern is matched, the error gets caught by the final catch clause and is bound to a local error constant
} // If an error is thrown, execution immediately transfers to the catch clauses, which decide whether to allow propagation to continue
// If no error is thrown, the remaining statements in the do statement are executed

func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Invalid selection, out of stock, or insufficient funds")
    }
}

do {
    try nourish(with: "Beet-flavored Chips")
} catch {
    print("Unexpected non-vending-machine-related error: \(error)")
}


// Method 3 : Converting Errors to Optional Values
// You use try? to handle an error by converting it to an optional value. If an error is thrown while evaluating the try? expression, the value of the expression is nil
func fetchData() -> Data? {
//    if let data = try? fetchDataFromDisk() { return data }
//    if let data = try? fetchDataFromServer() { return data }
    return nil
}

// Method 4 : Disabling Error Propagation
//let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")


// Specifying Cleanup Actions
//A defer statement defers execution until the current scope is exited
/* func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
} */
