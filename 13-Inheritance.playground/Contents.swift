//: Playground - noun: a place where people can play

import UIKit


class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "Vehicle traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        print("~makes noise~~")
    }
    
}

class Bicycle: Vehicle { //subclassing, inherits properties & methods of Vehicle
    var hasBasket = false
}

let bicycle = Bicycle()
let bicycle2 = Bicycle()
bicycle.hasBasket = true
print(bicycle.hasBasket)
print(bicycle2.hasBasket)

class Tandem: Bicycle { //subclassing subclasses, inherits properties & methods of Bicycle and Vehicle
    var currentNumberofPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentSpeed = 2
print(tandem.description)


//overriding methods
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
        super.makeNoise() // calling SuperClass' method within override method
    }
}
let train = Train()
train.makeNoise()

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + "in gear \(gear)"
    }
}
let car = Car()
print(car.description)

//overriding property observers
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1 //calculates gear from currentSpeed
        }
    }
}
let auto = AutomaticCar()
auto.currentSpeed = 35
print(auto.description)
