//: Playground - noun: a place where people can play

import UIKit

// A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
} // Always prefix type property requirements with the static keyword when you define them in a protocol

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + "" : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
print(ncc1701.fullName)

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m) )
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("Here's a random number: \(generator.random())")


//Mutating method requirements
protocol Togglable {
    mutating func toggle()
}
enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

protocol SomeProtocol2 {
    init(someParameter: Int)
}
class SomeClass: SomeProtocol2 {
    required init(someParameter: Int) { //'required' modifier ensures you provide an explicit or inherited implementation of the initializer requirement on all subclasses of the conforming class, such that they also conform to the protocol
        // initializer implementation
    }
}
protocol SomeOtherProtocol {
    init()
}
class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}
class SomeSubClass: SomeSuperClass, SomeOtherProtocol {
    required override init() {
        // initializer implementation goes here
    }
}

// Any protocol you create will become a fully fledged typed for use in code
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator // protocol as a type
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator()) //instace of type that adopted the RandomNumberGenerator protocol
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate: AnyObject { //assign protocol to object
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}
class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    weak var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self) //startgame
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll) //Delegates are a design pattern that allows one object to send messages to another object when a specific event happens
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self) //endgame
    }
}
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) { // game is of type DiceGame
        numberOfTurns = 0
        if game is SnakesAndLadders { // check if object is a subtype of a given type -> checks if SnakeAndLadders is of type DiceGame
            print("Started a new game")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}
let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


// extending an existing type to conform to a new protocol
protocol TextRepresentable {
    var textualDescription: String { get }
}
extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.textualDescription)

//extension Array: TextRepresentable where Element: TextRepresentable {
//    var textualDescription: String {
//        let itemsAsText = self.map { $0.textualDescription }
//        return "[" + itemsAsText.joined(separator: ", ") + "]"
//    }
//}
//let myDice = [d6, d12]
//print(myDice.textualDescription)

// make a type adopt a protocol with an empty extension
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simonnnnn")
//let somethingTextRepresentable: TextRepresentable = simonTheHamster
//print(somethingTextRepresentable.textualDescription)
print(simonTheHamster.textualDescription)


// Collection of protocol types
let things: [TextRepresentable] = [game, d12, simonTheHamster] // collection of 'textrepresentable' types
for thing in things {
    print(thing.textualDescription)
}


// Protocol inheritance
protocol PrettyTextRepresentable: TextRepresentable { // inheriting the 'TextRepresentable' protocol
    var prettyTextualDescription: String { get }
} //anything that adopts this protocol must satisfy requirements of both protocols
extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
    var output = textualDescription + ":\n" //accessing textualDescription proerpty from the textRepresentable
    for index in 1...finalSquare {
        switch board[index] {
    case let ladder where ladder > 0:
    output += "▲ "
    case let snake where snake < 0:
    output += "▼ "
    default:
    output += "○ "
            }
        }
        return output
    }
}
print(game.prettyTextualDescription)


// Limiting protocol adoption to class types by adding 'AnyObject' protocol
protocol SomeClassOnlyProtocol: AnyObject, SomeOtherProtocol {
    // class-only protocol defintion goes here
} // protocol can only be adopted by class types, and not struct or enum types


// Combining multiple protocols into a single requirement with a protocol composition
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person2: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) { //combining 2 protocols into a single requirement
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)")
}
let birthdayPerson = Person2(name: "Malcolm", age: 21) //conforming to protocol composition
wishHappyBirthday(to: birthdayPerson)

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)


// Checking for Protocol Conformance
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.145927
    var radius: Double
    var area: Double { return pi * radius * radius } //computed property
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double //stored property
    init(area: Double) { self.area = area }
} //Both classes conform to the 'HasArea' protocol

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}
let objects: [AnyObject] = [ //intialized with an array literal containing a 'Circle','Country','Animal' instance
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]
for object in objects { //iterate over each object
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}


// Optional Protocol Requirements
// When you use a method or property in an optional requirement, its type automatically becomes an optional
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}
class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}
//CounterDataSource implementation
class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}
var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
} // implementing optional fixedIncrement property requirement

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}
counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}


// Protocol extensions
protocol testProtocol {
    var testNum: Int { get }
}
extension testProtocol {
    func randomNum() {
        // return something
    }
}

extension RandomNumberGenerator { //extending the 'RandomNumberGenerator' protocol to provide a randomBool() method
    func randomBool() -> Bool {
        return random() > 0.5
    }
}
let generator2 = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("Here's a random Boolean: \(generator.randomBool())")


// Providing default implementations
extension PrettyTextRepresentable {
    var prettyTextualDescription: String { // default implentation to return the result of accessing the textualDescription property
        return textualDescription
    }
}


// Addding constraints to protocol extensions
extension Collection where Element: Equatable { // an element includes Int, String, Class
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    } // allEqual() method returns true only if all the elements in the collection are equal
}
let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]
print(equalNumbers.allEqual()) // returns true since all numbers are equal
print(differentNumbers.allEqual()) // returns false since all numbers are not equal
