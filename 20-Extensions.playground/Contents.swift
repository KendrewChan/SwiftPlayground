//: Playground - noun: a place where people can play

import UIKit

// Extensions add new functionality to an existing class, structure, enumeration, or protocol type

// Add computed instance properties and computed type properties
// Define instance methods and type methods
// Provide new initializers
// Define subscripts
// Define and use new nested types
// Make an existing type conform to a protocol

// Protocols can be extended to provide implementations of its requirements or add additional functionality that conforming types can take advantage of

extension Double {
    var km: Double { return self * 1_000.0}
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
let fiveKm = 5.km
print("fiveKm is \(fiveKm)meters")
let totalMeters = 13.km + 150.ft + 30.mm
print("totalMeters is \(totalMeters)")


// Extensions can add new convenience initializers to existing types, but they cannot add new designated initializers or deinitializers to a class
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width/2)
        let originY = center.y - (size.height/2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0)) // 2nd inititalizer that uses 'center' instead of 'origin'

//Extensions can add new instance methods and type methods to existing types -> where types == Int, Double, String, etc
extension Int { // adds available dot syntax to 'Int' types
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}
3.repetitions { // -> Int.square
    print("hello")
}

// Instance methods added with an extension can also modify (or mutate) the instance itself
extension Int { // adding a method aka function to 'Int' types
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()

// Extensions can add new subscripts to an existing type
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10 // -> if [1], then 1 * 10 * 10 == 100 -> so to the 100th place or the 2nd number from the right
        }
        return (self / decimalBase) % 10
    }
}
1312312455[0]
12362[1]
98436[0]


// Extensions can add new nested types to existing classes, structures, and enumerations
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}
3.kind
(-1).kind
0.kind
func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])

