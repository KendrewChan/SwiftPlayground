//: Playground - noun: a place where people can play

import UIKit

//Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence

//use subscripts to set and retrieve values by index without needing separate methods for setting and retrieval

//You can define multiple subscripts for a single type, and the appropriate subscript overload to use is selected based on the type of index value you pass to the subscript. Subscripts are not limited to a single dimension, and you can define subscripts with multiple input parameters to suit your custom type’s needs.

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])") //6 is the index -> 'index: Int'


//Subscripts are typically used as a shortcut for accessing the member elements in a collection, list, or sequence
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4] //Swift’s Dictionary type implements a subscript to set and retrieve the values stored in a Dictionary instance
numberOfLegs["bird"] = 2 //subscript assignment used to add a String key of "bird" and an Int value of 2 to the dictionary

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double { //subscript’s getter and setter both contain an assertion to check that the subscript’s row and column values are valid
        get {
            //convenience method indexIsValid(row:column:) checks whether the requested row and column are inside the bounds of the matrix
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2) // -> array wise will be 0, 1
matrix[0, 1] = 1.5 //1st row & 2nd column value -> 1.5
matrix[1, 0] = 3.2 //2nd row & 1st column value -> 3.2
//
let someValue = matrix[1, 1] // -> hence matrix[2, 2] won't work since 2 rows 2 columns means 0, 1
