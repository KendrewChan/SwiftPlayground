//: Playground - noun: a place where people can play

import UIKit

// starting with Arrays

var shoppingList: [String] = ["Eggs", "Milk"]
// shoppingList has been initialized with two initial items
// var shoppingList = ["Eggs", "Milk"] works fine too

if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}
// Prints "The shopping list is not empty."

shoppingList.append("Flour") //basic appending
shoppingList += ["Baking Powder"] //another way to append :)
var firstItem = shoppingList[0] //obtaining first item in an array
shoppingList[0] = "Six eggs" //change the first item to a different value
// in documentation terms, "use subscript syntax to change an existing value at a given index"

shoppingList[1...3] = ["Bananas", "Apples", "Oranges", "Test"] //1...3 index must lie within the range of array indexes
// shoppingList now contains 6 items
print(shoppingList)

shoppingList.insert("Maple Syrup", at: 0) //inserts instead of replacing
// "Maple Syrup" is now the first item in the list
print(shoppingList)
let apples = shoppingList.removeLast()
// the last item in the array has just been removed
print(shoppingList)

for item in shoppingList {
    print(item)
}

///////////////////////
// Complex stuff begins :(

for (index, value) in shoppingList.enumerated() { //For each item in the array, the enumerated() method returns a tuple composed of an integer and the item.
    print("Item \(index + 1): \(value)")
}

/////////


//Set Type Syntax
// Unlike arrays, sets do not have an equivalent shorthand form
// Sets are an unordered collections of unique values
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
// Prints "letters is of type Set<Character> with 0 items."
letters.insert("a") //letters now conains 1 value of type Character
print(letters)
print(letters.count)
letters = [] //now becomes an empty set
print(letters)

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
//A set type cannot be inferred from an array literal alone, so the type Set must be explicitly declared
var favoriteGenre: Set = ["Rock", "Classical", "Hip hop"] //a shorter version
//because of Swift’s type inference, you don’t have to write the type of the set if you’re initializing it with an array literal containing values of the same type
//meaning, if all values are of the same type "String", swift automatically infers a 'String' type for the set
print("I have \(favoriteGenres.count) favorite music genres.")

if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}

favoriteGenres.insert("Jazz")

if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.") //set can also be removed with its removeAll() method
}

if favoriteGenres.contains("Funk") { //check whether a set contains a particular item
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}

for genre in favoriteGenres { //iterate over the values in a set
    print("\(genre)")
}
for genre in favoriteGenres.sorted() { //default is 'sorted(by: <)'
    print("\(genre)")                // can try 'sorted(by: >)'
}


let oddDigits: Set = [1,3,5,7,9]
let evenDigits: Set = [0,2,4,6,8]
let singleDigitPrimeNumbers: Set = [2,3,5,7]

oddDigits.union(evenDigits).sorted()//combine both
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted()//common integers between odd and evenDigits
// []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted() //3,5,7 subtracted from oddDigits
// [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()//combine both and subtract common ones, opposite of intersection
// [1, 2, 9]





