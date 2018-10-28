//: Playground - noun: a place where people can play

import UIKit

struct Fahrenheit {
    var temp: Double
    init() {
        temp = 32.0
    }
}
var f = Fahrenheit()
print(f.temp)

struct Fahrenheit2 { //simpler form without initializers
    var temp = 32.0
}

//intialization parameters as part of an initializer's definition
struct Celcius {
    var tempInCelcius: Double
    init(fromFahrenheit fahrenheit: Double) {
        tempInCelcius = (fahrenheit - 32.0) / 1.8
    }
    //multiple initializers
    init(fromKelvin kelvin: Double) {
        tempInCelcius = kelvin - 273.15
    }
}
let boilingFahrenheit = Celcius(fromFahrenheit: 212.0)
print(boilingFahrenheit.tempInCelcius)
let freezingKelvin = Celcius(fromKelvin: 273.15)
print(freezingKelvin.tempInCelcius)

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(_ white: Double) { //initializer parameters without argument labels
        red = white
        green = white
        blue = white
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(0.5)

class SurveyQuestion {
    var text: String //constant property can be used too, as long as it is set to a definite value by the time initialization finishes
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
    func reply() {
        print(response!)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I love cheese :)"
cheeseQuestion.reply()

class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem() //default initializers
print(item.name) //default value of nil
print(item.quantity)

//struct types automatically receive a memberwise initializer if no definition
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0) //automatically initialized


//initializer delegation -> call other initializers to perform part of an instance's initialization
//value types -> do not support inheritance, reference types -> can inherit from other classes

struct Size2 {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    //For value types, you use self.init to refer to other initializers from the same value(struct,enum) type when writing your own custom initializers. You can call self.init only from within an initializer
    var origin = Point()
    var size = Size()
    init() { }
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width/2) //center.x represents initial value of x
        let originY = center.y - (size.height/2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let basicRect = Rect() //initialized with empty initializer above

let originREct = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0)) //simply assigns the origin and size argument values to the appropriate store properties

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0)) //calculates appropriate origin point base on 'center' point and 'size' value -> then calls (or delegates) to the init(origin:size:) initializer, which stores the new origin and size values in the appropriate properties
// center.x == 4.0, center.y == 4.0, size.width == 3.0, size.height == 3.0


//Class inheritance and initilization -> read documentation

//Desginated initializers -> primary initializers for a class
// A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain

//Convenience initializers -> supporting initializers
// You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type


//Initializer inheritance and overriding
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheels"
    }
}
let vehicle = Vehicle()
print("Vehicle has \(vehicle.description)")

class Bicycle: Vehicle { //subclass
    override init() { //override superclass'/'Vehicle' initializer
        super.init() //delegate superclass' initializer before able to change superclass' properties
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
print("Vehicle has \(bicycle.description)")


// Designated and convenience initializers in action
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon") //uses designated initializer
let mysteryMeat = Food() //user convenience initializer
print(namedMeat.name)
print(mysteryMeat.name)

class RecipeIngredient: Food { //subclass
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity //call class' properties first
        super.init(name: name) //designated initializer -> superclass' designated initializer
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1) //convenience intializer -> designated initializer
    }
}
let mysteryItem = RecipeIngredient()
print(mysteryItem.name)
let oneBacon = RecipeIngredient(name: "Bacon")
print(oneBacon.name)
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
print(sixEggs.name, sixEggs.quantity)


class ShoppingListItem2: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}
var breakfastList = [ShoppingListItem2(),
                     ShoppingListItem2(name: "Bacon"),
                     ShoppingListItem2(name: "Eggs", quantity: 12),
]
breakfastList[0].name = "Orange Juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}


//Failable initializers
var wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}
wholeNumber = 123
let valueChanged = Int(exactly: pi)

if valueChanged == nil {
    print("\(pi) conversion to Int does not maintain value")
}

struct Animal {
    let species: String
    init?(species: String) { //failable initializer defined to check if 'species' value passed to initializer is an empty string
        if species.isEmpty { return nil }
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("\(anonymousCreature?.species) cannot be initialized")
}

//Failable initializers for enumerations
enum TemperatureUnit {
    case kelvin, celcius, fahrenheit
    init?(symbol: Character) { //failable initializer for enumeration
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celcius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, initialization succeeded")
}
let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, initialization failed")
}
//Failable initializers for enumerations with raw values
enum TemperatureUnit2: Character { //only 'Character' values
    case kelvin = "K", celcius = "C", fahrenheit = "1"
}
let fahrenheitUnit2 = TemperatureUnit2(rawValue: "1")
if fahrenheitUnit2 != nil {
    print("initialization succeeded")
}
let unknownUnit2 = TemperatureUnit2(rawValue: "X")
if unknownUnit2 == nil {
    print("initialization failed")
}


//Propagation of failure initializers
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name) //calls the failable initializer of 'Product'
    }
}

if let twoSock = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSock.name), quantity: \(twoSock.quantity)")
}
if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)") //initialization failed
}

if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("unable to intialize")
}


//Overriding a failable initializer
// You can override a superclass failable initializer in a subclass
// Alternatively, you can also override a superclass failable initializer with a subclass nonfailable initializer
class Document {
    var name: String?
    init() {} //empty intializer
    init?(name: String) { //failable initializer
        if name.isEmpty { return nil }
        self.name = name
    }
}
class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) { //replaces superclass' failable initializer with a non-failable initializer
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}
let autoDoc = AutomaticallyNamedDocument()
print(autoDoc.name!)
let autoDoc2 = AutomaticallyNamedDocument(name: "Steven")
print(autoDoc2.name!)
class UntitledDocument: Document {
    override init() {
        super.init(name: "[hello]")! //use the failable init from superclass
    }
}

// 'Required' intializers
class SomeClass {
    required init() { // required modifier indicates that every subclass of the class must implement the intializer
        }
}
class SomeSubClass: SomeClass {
    required init() { // subclass must also write the 'required' modifier, also 'override' modifier not needed when overriding
        
    }
}


//How a closure can be used to provide a default property value
struct ChessBoard {
    let boardColors: [Bool] = { //initialized with a closure
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 { //initializing the alternate colors of the chessBoard
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}
let board = ChessBoard()
print(board.squareIsBlackAt(row: 0, column: 1) )
print(board.squareIsBlackAt(row: 3, column: 8) )
print(board.squareIsBlackAt(row: 5, column: 3) )
