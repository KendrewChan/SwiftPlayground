//: Playground - noun: a place where people can play

import UIKit

// Multiplication

func iterativeMult(_ a: Int, _ b: Int) -> Int {
    var finalValue = 0
    var bCount = b
    while bCount > 0 {
        finalValue += a
        bCount -= 1
    }
    return finalValue
}
iterativeMult(50, 400)

func recursiveMult(_ a: Int, _ b: Int) -> Int {
    if b == 1 {
        return a
    } else {
        return a + recursiveMult(a, b - 1)
    }
}
recursiveMult(50, 400)


// Factorial

func iterativeFact(_ a: Int) -> Int {
    var b = a
    var finalValue = 1 // factorials have to start with 1
    while b > 0 {
        finalValue = finalValue * b
        b -= 1
    }
    return finalValue
}
iterativeFact(5)

func iterativeFact2(_ a: inout Int) -> Int {
    var finalValue = 1 // factorials have to start with 1
    while a > 0 {
        finalValue = finalValue * a
        a -= 1
    }
    return finalValue
}
var a = 5
iterativeFact2(&a) // inout only works when 'var a = 5' is put as the parameter

func recursiveFact(_ a: Int) -> Int {
    if a == 1 {
        return 1
    } else {
        return a*recursiveFact(a - 1)
    }
}
recursiveFact(5) // 5! == 5 x 4 x 3 x 2 x 1 == 20 x 6 == 120
