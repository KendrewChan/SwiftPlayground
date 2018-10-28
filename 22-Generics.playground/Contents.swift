//: Playground - noun: a place where people can play

import UIKit

// Generic code enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define. You can write code that avoids duplication and expresses its intent in a clear, abstracted manner.

//Example of generic collections -> Arrays and Dictionaries
// Reason: Arrays can hold Int values, String valuesor any other type of values


func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
} // in-out parameter is for functions to modify a parameter's value

var someInt = 3
var anotherInt = 108
swapTwoInts(&someInt, &anotherInt)
print("someInt: \(someInt) and anotherInt: \(anotherInt)")
// swapTwoInts function can only be used with Int values

// Converting to generic function
func swapTwoValues<T>(_ a: inout T, _ b: inout T) { // notice the <T> and the T are placeholder values -> any other word/letter will work as well
    let temporaryA = a
    a = b
    b = temporaryA
} // placeholder type name called 'T', says that both a and b must be of the same type 'T' -> hence type T is inferred from the types of values passed
swapTwoValues(&someInt, &anotherInt)
var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)


// Generic Types
// generic collection type called Stack
// Compared to an array that allows new items to be inserted and removed at any location in the array, a stack allows new items to be appended only to the end of the collection (aka 'pushing')
// Similarly, items can only be removed from the end of the collection
// Basically, imagine a stacking game, where u can only stack and remove the top parts

struct IntStack { // nongeneric version of a stack
    var items = [Int]()
    mutating func push(_ item: Int) { // mutating, because they need to modify (or mutate) the structure’s items array.swi
        items.append(item)
    }
    mutating func pop() -> Int { // mutating functions allow for a its type's(struct) properties(var) to change in value
        return items.removeLast()
    }
}

struct Stack<Element> { // generic version of a stack
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
} // 'Element' defines a placeholder name for a type to be provided later
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("don")
stackOfStrings.push("von")
stackOfStrings.push("con")
print(stackOfStrings)
stackOfStrings.pop()
print(stackOfStrings)
// Hence, 'Stack' is useful for making things like card games


// Extending a generic type
extension Stack {
    var topItem: Element? { // to find the topItem
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}


// Type constraints specify that a type parameter must inherit from a specific class, or conform to a particular protocol or protocol composition
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? { // non-generic algorithm to search through arrays and return the index of a value
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

func findIndex<Placebo: Equatable>(of valueToFind: Placebo, in array:[Placebo]) -> Int? { // Equatable required to allow "==" because, If you create your own class or structure to represent a complex data model, for example, then the meaning of “equal to” for that class or structure(pertaining to the various types?) isn’t something that Swift can guess for you
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
} // generic algorithm to search through arrays and return the index of a value, -> 'Placebo' can also be 'T', etc

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
// optional Int with no value since 9.3 isn't in the array
let stringIndex = findIndex(of: "Jovynna", in: ["Mike", "Malcolm", "Jovynna"])
// optional Int containing a value of 2


// Associated Types
protocol Container {
    associatedtype Item // only items of the right type are added to the container
    mutating func append(_ item: Item) // add new items of type 'Item'
    var count: Int { get } // access count of items in container with type of Int
    subscript(i: Int) -> Item { get } // retrieve each item in the container with subscript
}
// non-generic version of IntStack type from earlier
struct IntStack2: Container {
    // original Instack implementation
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    typealias Item = Int
    
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}
// generic version of IntStack type from earlier
struct Stack2<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

protocol Container2 {
    associatedtype Item: Equatable // only items of the right type are added to the container -> adding Equatable causes the container's 'Item' type to conform the Equatable protocol
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

protocol SuffixableContainer: Container2 {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack2: SuffixableContainer {
    func suffix(_ size: Int) -> Stack2 {
        var result = Stack2()
        for index in (count - size) ..< count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack
}
var stackOfInts = Stack2<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)

extension IntStack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack<Int> {
        var result = Stack<Int>()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack<Int>.
}


// Generic Where Clauses
// A generic where clause enables you to require that an associated type must conform to a certain protocol, or that certain type parameters and associated types must be the same
