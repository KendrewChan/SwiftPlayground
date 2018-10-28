//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Monster {
    
    var health = 0
    var dmg = 0
    
    init (_ health: Int, _ dmg: Int) {
        self.health = health
        self.dmg = dmg
    }
}

var monster1 = Monster(1, 1)
var monster2 = Monster(2, 2)

monster1.health
monster1.dmg

monster2.health
monster2.dmg

/////////////////////

class Music { // class that encapsulates an array and flattens it into a string
    let notes: [String]
    
    init(notes: [String]) {
        self.notes = notes
    }
    
    func prepared() -> String { //this is the method that flattens the "notes" array into a string
        return notes.joined(separator: " ")
    }
}

class Instrument {
    let brand: String //this is called a property
    
    // purpose is to construct new instruments by initializing all stored properties
    init(brand: String) {
        self.brand = brand
    }
    
    //functions inside a class are called methods
    func tune() -> String { //tune() method is a placeholder function that crashes at runtime if you call it
        fatalError("Implement this method for \(brand)")
    }
    
    func play(_ music: Music) -> String { //input "music" and outputs a string
        return music.prepared() // returns the "notes" array in the form of a string
    }
    
    func perform(_ music: Music) {
        print(tune())
        print(play(music))
    }
}

let a = Instrument(brand: "avaron")
a.brand
let m = Music(notes: ["fa","so","la"])
a.play(m)
a.play(Music(notes: ["hello","its me"]))  // longer version
Instrument(brand: "aberon").play(Music(notes: ["in","the","end","i","tried","so","hard"])) //even longer version


class Piano: Instrument { //Piano class as a subclass of the Instrument parent class. All the stored properties and methods are automatically inherited by the Piano child class and available for use.
    let hasPedals : Bool
    
    //keys on all pianos are constant, so you mark the properties as static to reflect this
    static let whiteKeys = 52 //Basically static => constant value and constant type
    static let blackKeys = 36 //static values cannot be converted, e.g. from Int to String, vice versa
    
    init(brand: String, hasPedals: Bool = false) {
        self.hasPedals = hasPedals
        
        super.init(brand: brand) //'brand: ' refers to 'Instrument(brand: )', whilst the ': brand' represents the Piano's brand
        // super keyword to call the parent class(Instrument) initializer after setting the child class stored property hasPedals. The super class initializer takes care of initializing inherited properties from Instrument — in this case, brand.
    }
    
    override func tune() -> String { //override the inherited tune()
        // thus provides an implementation of tune() that doesn’t call fatalError(), but rather does something specific to Piano
        return "Piano standard tuning for \(brand)."
    }
    
    override func play(_ music: Music) -> String { //override inherited play(_:)
        let preparedNotes = super.play(music)
        return "Piano playing \(preparedNotes)"
    }
    
    func play(_ music: Music, usingPedals: Bool) -> String { //overloads the "override play(_:)" method to use pedals if usingPedals is true and the piano actually has pedals to use. It does not use the override keyword because it has a different parameter list
        let preparedNotes = super.play(music)
        if hasPedals && usingPedals {
            return "Play piano notes \(preparedNotes) with pedals."
        } else {
            return "Play piano notes \(preparedNotes) without pedals."
        }
    }
}

/* let p = Piano(brand: "",hasPedals: true)
p.play(m,usingPedals: true) //both func works
p.play(m) */


// 1
let piano = Piano(brand: "Yamaha", hasPedals: true)
piano.tune()
// 2
let music = Music(notes: ["C", "G", "F"])
piano.play(music, usingPedals: false)
// 3
piano.play(music)
// 4
Piano.whiteKeys //static var can directly call without instance of piano
Piano.blackKeys

class Guitar: Instrument{
    let stringGauge: String
    
    init(brand: String, stringGauge: String = "medium") {
        self.stringGauge = stringGauge
        super.init(brand: brand) //inherit brand from parent/super class
    }
}

let g = Guitar(brand: "yamaha") //this works too
g.brand
g.stringGauge
let g1 = Guitar(brand: "yadama",stringGauge: "soft") //this works fine too, thus both method works
g1.brand
g1.stringGauge


class AcousticGuitar: Guitar {
    static let numberOfStrings = 6
    static let fretCount = 20
    
    override func tune() -> String {
        return "Tune \(brand) acoustic with E A D G B E"
    }
    
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music) //super loads from the guitar superclass
        return "Play folk tune on frets \(preparedNotes)."
    }
}

let AG = AcousticGuitar(brand: "Roland")
AG.tune()
AG.play(m)


/* class Instrument {
    let brand: String
    let notes: [String]
 
    init(brand: String, notes: [String]) {
        self.brand = brand
        self.notes = notes
    }
    
    //functions inside a class are called methods
    func tune() -> String {
        fatalError("Implement this method for \(brand)")
    }
    
    func play() -> String {
        return notes.joined(separator: " ")
    }
}

let a = Instrument(brand: "avaron", notes: ["hello", "its me"])
a.brand
a.notes
a.play()*/   // same as above without adding Music class, but difficult to adjust vocab?

