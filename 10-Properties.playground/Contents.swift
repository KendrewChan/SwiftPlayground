//: Playground - noun: a place where people can play

import UIKit


//recap: Structure instances -> value type; Class instances -> Reference type
struct  FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 3 //reports an error due to constant 'let'
//even though firstValue is a var, since the instance is a value type marked as a constant, so are all of its properties

class DataImporter { //class to import data from an external file
    var filename = "data.txt"
}

class DataManager { //purpose of this class is to manage and provide access to this array of String data
    lazy var importer = DataImporter() //provides the ability to import data from a file
    var data = [String]()
} //it is possible for the DataManager instance to manage its data without ever importing data from a file, so there is no need to create a new DataImporter instance when the DataManager instance itself is created. Thus, it makes more sense to create the DataImporter instance if and when it is first used

let manager = DataManager()
manager.data.append("Some Data")
manager.data.append("More Data") //here, DataImporter instance has not yet been created
print(manager.importer.filename) //DataImporter instance for the importer propery created

struct Point { //encapsulates the x- and y- coordinate
    var x = 0.0, y = 0.0
}
struct Size { //encapsulates the width and height
    var width = 0.0, height = 0.0
}
struct Rect { //defines a rectange by an origin point and a size
    var origin = Point()
    var size = Size()
    
    var center: Point { //center determined by origin and size
        get {
            let centerX = origin.x + (size.width/2)
            let centerY = origin.y + (size.height/2)
            return Point(x: centerX, y: centerY) //calculates center from origin value denoted
        }
        set(newCenter) { //if 'newCenter' not defined, 'newValue' is automatically used -> newValue.x && newValue.y
            origin.x = newCenter.x - (size.width/2)
            origin.y = newCenter.y - (size.height/2) //calculates origin from newCenter value provided
            
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width:10.0, height:10.0) )

print("square.origin is originally at \(square.origin.x), \(square.origin.y)")
let initialSquareCenter = square.center //initial center
square.center = Point(x: 15.0, y: 15.0) //new center
print("square.origin is now at \(square.origin.x), \(square.origin.y)") //look at newCenter's formular -> (15.0 - 10.0/2) = 10.0

//Read-Only Computed Properties
struct Cuboid { //Read-Only Computed Properties always returns a value but cannot be set to a different one shown below
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("volume of 4by5by2 is \(fourByFiveByTwo)")
//fourByFiveByTwo.volume = Cuboid(width: 5, height: 5, depth: 5) //set {} required to set new center value, otherwise error occurs as shown


//Property Observers
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
            print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
//About to set totalSteps to 200 -> willSet
//Added 200 steps -> didSet
stepCounter.totalSteps = 360
//About to set totalSteps to 360
//Added 160 steps
stepCounter.totalSteps = 896
//About to set totalSteps to 896
//Added 536 steps



//Type Properties
struct SomeStructure {
    var testProperty = "Valueable"
    static var storedTypeProperty = "Some value" //static constants and variables can be accessed globally(shown below)
    static var computedTypeProperty: Int { //same thing <<
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 1
    }
}
class SomeClass {
    static var storedTypePropery = "Some value"
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
print(SomeStructure.storedTypeProperty) //No need to create an instance to use a 'static var/let' property
// print(SomeStructure.testProperty) //doesn't work <<
/* Create an instance first */ let someStruct = SomeStructure()
print(someStruct.testProperty) //Need to create an instance before being able to use a 'var/let' property

SomeStructure.storedTypeProperty = "Another Value" //able to change easily without an instance
print(SomeStructure.storedTypeProperty)
print(SomeStructure.computedTypeProperty)
print(SomeClass.computedTypeProperty)


//Example of using Type Properties
struct AudioChannel {
    static let thresholdLevel = 10 //max 'audio' level
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet { //if 'didSet' greater than 10, cap it back to 10 -> didSet property observer to check the value of currentLevel whenever it is set
            if currentLevel > AudioChannel.thresholdLevel { //cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels { //setting the 'audio' level whenever it is changed
                //store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}
//use AudioChannel structure to create 2 new audio channels
var leftChannel = AudioChannel() //creating an instance
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7 //instance needed to call currentLevel, since it is not a static var
print(leftChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels) //'maxInputLevelForAllChannels' automatically updated to currentLevel

rightChannel.currentLevel = 11 //trying to set currentLevel to greater than 10
print(rightChannel.currentLevel) //'currentLevel' capped to 10
print(AudioChannel.maxInputLevelForAllChannels) //'maxInputLEvelForAllChannels' also capped to 10, following currentLevel


