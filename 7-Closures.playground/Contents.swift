//: Playground - noun: a place where people can play

import UIKit

//Closure Expressions
let names = ["Chris","Akex","Ewa","Barry","Daniella"]
func backward(_ s1:String, _ s2:String) -> Bool {
    return s1 > s2 //for characters in Strings, 'greater than' means 'appears later in the alphabet'
    //thus, B > A and E > D
}
var reversedNames = names.sorted(by: backward)
print(reversedNames)

var reversedNames2 = names.sorted(by: {(s1: String, s2: String) -> Bool in return s1 > s2})
print(reversedNames2)

var reversedNames3 = names.sorted(by: {s1, s2 in return s1 > s2} )
print(reversedNames3)
var reversedNames4 = names.sorted(by: {s1, s2 in s1 > s2} )
print(reversedNames4)
var reversedNames5 = names.sorted(by: {$0 > $1}) //$0,$1,$2 refers to the value of the closure's arguments
print(reversedNames5)
var reversedNames6 = names.sorted(by: >) //inference by swift
print(reversedNames6)



//Trailing Closures
func someFunctionThatTakesAClosure(closure: () -> Void) {
    //body
}
someFunctionThatTakesAClosure(closure: { //calling func without using trailing closure
    //body
})
someFunctionThatTakesAClosure() { //calling func using trailing closure
    //body
}

let digitNames = [0: "Zero", 1:"One", 2:"Two",3:"Three",4:"Four",
                  5:"Five",6:"Six",7:"Seven",8:"Eight",9:"Nune"]
let numbers = [16,58,510]
let strings = numbers.map { (number) -> String in
    var number = number //var number is initialized with the value of the closure's number parameter
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output //returns the string correlated to the int, e.g. 16 returns "Six" + "", after the loop, it becomes "One" + "Six"
        number /= 10 //Since it is an integer, number is rounded down, 16 -> 1, 58 -> 5, 510 -> 51
    } while number > 0
    return output
}
print(strings)

func makeIncrementer(forIncrement amount: Int) -> () -> Int { // the return type () -> Int means it returns a function rather than a simple value
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount //runningTotal and amount are both from the func's surronuding context
        return runningTotal
    } //capturing by reference ensure that runnignTotal and amount do not disappear when the call to makeIncrementer ends, and also ensures that runningTotal is available the next time the incrementer function is called
    return incrementer
}
let incrementByten = makeIncrementer(forIncrement: 10)
let incrementByfive = makeIncrementer(forIncrement: 5)
let alsoIncreaseTen = incrementByten //reference type

// Escaping Closures
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) { //marking a closure with the @escaping means you have to refer to self explicitly within the closure
    completionHandlers.append(completionHandler)
}

func someFunctionWithNoneEscapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNoneEscapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)

instance.doSomething()
print(instance.x)

//Autoclosures
var customersInLine = ["Chris","Akex","Ewa","Barry","Daniella"]
let customerProvider = { customersInLine.remove(at: 0)}
print(customersInLine.count)
print("Now serving \(customerProvider())!") //prints with Chris whilst removing him
print(customersInLine.count)
// without Autoclosures
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!") //curly braces required
}
serve(customer: { customersInLine.remove(at: 0) } )
// with Autoclosures
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0) ) //does not require curly braces

