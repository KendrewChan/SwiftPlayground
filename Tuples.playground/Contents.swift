//: Playground - noun: a place where people can play

import UIKit

var someTuple = (top: 10, bottom: 12)
someTuple = (top: 4, bottom: 42)
print(someTuple.top)
print(someTuple.bottom)
someTuple = (0, 99)
print(someTuple.top)
print(someTuple.bottom)
//someTuple = (left: 5, right: 5) //error received, can't be substituted

func someFunction(left: Int, right: Int) { }
func anotherFunction(left: Int, right: Int) { }
func funcWithDifferentLabels(top: Int, bottom: Int) { }

//var f = someFunction // The type of f is (Int, Int) -> Void, not (left: Int, right: Int) -> Void.
//f = anotherFunction              // OK -> same type
//f = functionWithDifferentLabels  // OK
//
//func functionWithDifferentArgumentTypes(left: Int, right: String) {}
//f = functionWithDifferentArgumentTypes     // Error
//
//func functionWithDifferentNumberOfArguments(left: Int, right: Int, top: Int) {}
//f = functionWithDifferentNumberOfArguments // Error -> different type

