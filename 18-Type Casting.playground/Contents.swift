//: Playground - noun: a place where people can play

import UIKit

// Type casting is a way to check the type of an instance, or to treat that instance as a different superclass or subclass from somewhere else in its own class hierarchy


// You can use type casting with a hierarchy of classes and subclasses to check the type of a particular class instance and to cast that instance to another class within the same hierarchy
class MediaItem {
    var name: String // declares a name property of type String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String // adds a director property on top of the base MediaItem class whilst reusing the superclass' initializer
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}
class Song: MediaItem {
    var artist: String // adds an artist property and initializer on top of the base class
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [ // constant array called Library
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
] // Swift’s type checker is able to deduce that Movie and Song have a common superclass of MediaItem, and so it infers a type of [MediaItem] for the library array

// Checking Type -> type check operator (is) to check whether an instance is of a certain subclass type
var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie { // The type check operator returns true if the instance is of that subclass type and false if it is not -> similar to '==' but instead of value, it refers to type
        movieCount += 1
    } else if item is Song { // checks if item is a 'Song' instance
        songCount += 1
    }
}
print("Media library contains \(movieCount) movies and \(songCount) songs")


// Downcasting -> A constant or variable of a certain class type may actually refer to an instance of a subclass behind the scenes
// Downcasting may fail ->
// 1. The conditional form, as?, returns an optional value of the type you are trying to downcast to -> use when unsure of success
// 2. The forced form, as!, attempts the downcast and force-unwraps the result as a single compound action -> use when certain of success
for item in library {
    if let movie = item as? Movie { // assign var to item of type 'Movie', also optional binding used to check whether the optional 'Movie' actually contains a value
        print("Move: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
    // each item in the array might be a Movie, or it might be a Song. You don’t know in advance which actual class to use for each item, and so it is appropriate to use the conditional form of the type cast operator (as?) to check the downcast each time through the loop
}


// Type Casting for Any and AnyObject
// 1. 'Any' can represent an instance of any* type at all, including function types -> any type
// 2. 'AnyObject' can represent an instance of any class* type -> only objects/classes
var things = [Any]() // 'Any' type

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

// Discover the specific type of a constant or variable that is known only to be of type Any or AnyObject
for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}
