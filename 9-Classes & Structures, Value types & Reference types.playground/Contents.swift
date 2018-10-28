//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var number: Int? //being optional gives it an initial value of nil

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

//Creating an Instance of a structure or class is very similar
let someResolution = Resolution()
let someVideoMode = VideoMode()
//dot notation/syntax used to access the properties of an instances

print("Width of someVideoMode is \(someVideoMode.resolution.width)") //drilling into sub-properties
someVideoMode.resolution.width = 1280 //assigning a new value through dot syntax

let res = Resolution(width: 640, height: 480) //all structures have an automatically-generated memberwise 'initializer'
print(res.width)

//Structures and Enumerations are value types
//Value types are types whose value is copied when it is assigned to a variable or constant, or when it is passed to a function
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd //even though hd and cinema now have the same 'width' and 'height', they are two completely different instances behind the scenes
cinema.width = 2048
print(cinema.width, hd.width) //to prove the point above

enum CompassPoint { //difference instances of value types
    case north,south,west,east
}
var currDirection = CompassPoint.west
let rememberedDirection = currDirection
currDirection = .east
print(currDirection, rememberedDirection) //similarly applies to enum


//Classes are Reference types
//Classes & Reference types are not copied when assigned to a variable or constant or when they are passed to a function
let tenEighty = VideoMode()
tenEighty.frameRate = 15.0
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print(tenEighty.frameRate, alsoTenEighty.frameRate) //Rather than a copy, a reference to the same existing instance is used instead
//Hence tenEighty & alsoTenEighty both refer to the same VideoMode 'instance'


//Identity Operators
// Identical -> '===' , Not identical -> '!=='
if tenEighty === alsoTenEighty { //check whether two constants or variables refer to the same 'instance'
    print("tenEighty & alsoTenEighty refer to the same instance, and may refer to a Class instance") //if tenEighty is a 'class' whilst alsoTenEighty is a 'struct', then they are '!==' or not identical too
} else {
    print("the two variables do not refer to the same instance and may refer to a Structure instance or Enumeration")
}

//Hence, Structure instances -> value type , Class instances -> reference type



