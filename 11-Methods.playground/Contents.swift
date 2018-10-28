//: Playground - noun: a place where people can play

import UIKit

//Methods are functions that are associated with a particular type -> value && reference types
//Classes -> reference type, Structure && Enumeration -> value type

//Instance methods
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
let counter = Counter() //creating an instance
counter.increment() //Instance method -> 'counter' is the instant && 'increment()' is the method
counter.increment(by: 5)
counter.reset()


//Self Property
class testCount {
    var count = 0
    func increment() {
        self.count += 1 //'self' property is only need when a parameter name for an instance method has the same name
    }
}
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool { //parameter of 'isToTheRightOf' has the same name as 'var x = 0.0'
        return self.x > x //'self.x' refers to the variable whilst 'x' refers to the parameter
    }
}
let somePoint = Point(x: 4.0, y: 5.0) //change the value of x & experiment
if somePoint.isToTheRightOf(x: 1.0) { //compares 'self.x == 4.0' with 'x = 1.0'
    print("somePoint is to the right of the line, where x == 1.0")
} else {
    print("somePoint is to the left of the line, where x == 1.0")
}


//Modifying Value Types from within instance methods
//Default: properties of a value type cannot be modified from within its instance methods
//However, 'mutating behaviour' for that method allows for modification
struct Point2 {
    var x = 0.0 , y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self.x += deltaX
        self.y += deltaY
    }
}
var somePoint2 = Point2(x: 1.0, y: 1.0) //where x and y both refers to 'deltaX' and 'deltaY'
//properties -> refer to the var && let || the constant and variable values of an instance -> somePoint2 is an example of an instance
somePoint2.moveBy(x: 2.0, y: 3.0) //this changes Point2's properties from within the method
somePoint2.x = 3 //this changes Point2's properties from outside the method
print("The point is now at (\(somePoint2.x), \(somePoint2.y))")

var fixedPoint = Point2(x: 3.0, y: 3.0)
fixedPoint.moveBy(x: 2.0, y: 3.0)
print("\(fixedPoint.x), \(fixedPoint.y)")

enum TriStateSwitch {
    case off, low, high //mutating methods for enumerations
    mutating func next() {
    switch self {
    case .off:
        self = .low
    case .low:
        self = .high
    case .high:
        self = .off
        } //move in a cycle where, off -> low -> high -> off -> low ....
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next() //ovenLight is now equal to .high
ovenLight.next() //ovenLight is now equal to .low

//Type methods
//Where Type Properties are created as 'static var' or 'static let'
//Type methods are created as 'static func() {}'
class SomeClass { //classes may also use the 'class' keyword to allow subclasses to override the superclass"s implementation of that method
    class func someTypeMethod() {
        //type method implementation goes here
    }
}
SomeClass.someTypeMethod()
//Example of type method as a LevelTracker
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) { //Type method
        if level > highestUnlockedLevel {highestUnlockedLevel = level}
        //Keeps track of and updates the highest unlocked levels
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
        //ensures current level is not higher than highest unlocked level
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool { //method to check whether the requested new level is already unlocked
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1) //set highest unlocked level
        tracker.advance(to: level + 1) //set current level
    }
    
    init(name: String) {
        playerName = name
    }
}
var player = Player(name: "Johnny")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Benje")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
