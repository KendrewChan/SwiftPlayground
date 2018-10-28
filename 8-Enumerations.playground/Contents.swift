//: Playground - noun: a place where people can play

import UIKit

// match individual enumeration values with a switch statement

enum CompassPoint {
    case north
    case south
    case east
    case west
}

var directionToHead = CompassPoint.east
directionToHead = .west
func direction() {
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
}
direction()
directionToHead = .north
direction()


enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
var somePlanet = Planet.mars
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}


enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
var productBarcode = Barcode.upc(8, 85909, 51226, 3) //to create new barcodes, assign it to a variable
productBarcode = .qrCode("ABCDEFGHIJKLMNOP") // comment this out to see the switch statement print different values

// same var can store different enum case values, however only 1 at a time

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."   Method 1, individually assign a "let" or "var"

switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check): //can place a single 'var' or 'let' instead of multiple
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."   Method 2, works if all are of the same type (constants/variables)




enum ASCIIControlCharacter: Character { // raw values here are defined to be of type Character
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}




enum Playnet: Int {
    case mercury, venus, earth = 2, mars, jupiter, saturn, uranus, neptune //change any value within the cases to see the entire enum's raw value change
} // change initial(raw) value of mercury to see rawValue change for the other cases
print(Playnet.earth.rawValue)
var planetNo = Playnet.uranus //change the "playnet" here to see the rawValue change
print(planetNo.rawValue)
let possiblePlanet = Playnet(rawValue: 4) //rawValue can be used to find enum cases
print(possiblePlanet!)

let positionToFind = 11
if let somePlanet = Playnet(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
// Prints "There isn't a planet at position 11"





enum ArithmeticExpression { //indicate that an enumeration case is recursive by writing indirect before it, which tells the compiler to insert the necessary layer of indirection
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression) //the (ArithmeticExpression, ArithmeticExpression) requires the 'indirect case'
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
//can also write indirect before the beginning of the enumeration to enable indirection for all of the enumeration’s cases that have an associated value
/* indirect enum ArithmeticExpression2 {
    case number(Int)
    case addition(ArithmeticExpression2, ArithmeticExpression2)
    case multiplication(ArithmeticExpression2, ArithmeticExpression2)
} */
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four) //five and four are both from 'ArithmeticExpression.number'
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right): //left & right are variables set as the ArithmeticExpression
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
print(evaluate(product))
print(evaluate(five))
print(evaluate(sum))

let leftNum = 10
let rightNum = 15
let left = ArithmeticExpression.number(leftNum)
let right = ArithmeticExpression.number(rightNum)
let sumUp = ArithmeticExpression.addition(left, right)
let productUp = ArithmeticExpression.multiplication(left, right)

let add = evaluate(sumUp)
let multiply = evaluate(productUp)
print(add)
print(multiply)
//hence change leftNum or rightNum to change value of add or multiply
