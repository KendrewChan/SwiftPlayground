//: Playground - noun: a place where people can play

import UIKit

// Optional chaining is a process for querying(validating) and calling properties, methods, and subscripts on an optional that might currently be nil
// Multiple queries can be chained together and the entire chain fails gracefuly if any link in the chain is nil



// Optional chaining as an alternative to force unwrapping

//Example to show how optional chaining differs from forced unwrapping and enables you to check for success
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}
let john = Person() // when creating a new person instance, its residence property is default initialized to nil
if john.residence == nil {
    print("initialized to nil")
}
//let roomCount = john.residence!.numberOfRooms -> runtime error as there is no 'residence' value to unwrap
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
john.residence = Residence() //assign a Residence instance to john.residence, so that it no longer has a nil value
if let roomCount = john.residence?.numberOfRooms {
    //john.residence now contains an actual Residence instance, rather than nil
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}


//  optional chaining with calls to properties, methods, and subscripts that are more than one level deep. This enables you to drill down into subproperties within complex models of interrelated types, and to check whether it is possible to access properties, methods, and subscripts on those subproperties
class Residence2 {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentfier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}


//Acessing properties through optional chaining
//use optional chaining to access a property on an optional value, and to check if that property access is successful
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
//john.residence?.address = someAddress -> *fail* since john.residence is currently nil

func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}
//john.residence?.address = createAddress() -> createAddress() function isn’t called, because nothing is printed


//Calling methods through optional chaining -> to check whether a method call is successful after calling it
func printNumberOfRooms() {
    print("The number of rooms is \(numberOfRooms)")
}

if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

