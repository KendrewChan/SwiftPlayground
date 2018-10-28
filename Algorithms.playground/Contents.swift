//: Playground - noun: a place where people can play

import UIKit

var testArray = [1, 3, 5, 7, 9]
print(testArray.index(of: 5))

for i in 1...testArray.count {
    print(testArray[i-1])
}
// algorithm to add +1 to array inserted as paramter
//func addToEach(L: inout [Int], F: Int -> Int) -> [Int] {
//    for i in 1...L.count {
//        L[i-1] = F(L[i-1])
//    }
//    return L
//}
//func addOne(_ i: Int) -> Int {
//    return i + 1
//}
//
//addToEach(L: &testArray, F: addOne)

//var testDict = [Int: [Int]]()
//var dictArray = [1, 1, 2, 3, 3, 4 ,5]
//
//func sortDict(array: [Int]) {
//    for i in array {
//        for key in testDict.keys {
//            if key == i {
//                testDict[key]?.append(i)
//            } else {
//                testDict[i] = [i]
//            }
//        }
//    }
//}
//
//sortDict(array: dictArray)


protocol Groupable {
    associatedtype GroupingType: Hashable
    var grouping: GroupingType { get set }
}

extension Array where Element: Groupable  {
    typealias GroupingType = Element.GroupingType
    
    func grouped() -> [[Element]] {
        var groups = [GroupingType: [Element]]()
        
        for element in self {
            if let _ = groups[element.grouping] {
                groups[element.grouping]!.append(element)
            } else {
                groups[element.grouping] = [element]
            }
        }
        
        return Array<[Element]>(groups.values)
    }
}

let dates = [123, 123, 123, 324, 324, 516, 0, 0]
let datesByDate = Dictionary(grouping: dates, by: { $0 })
print(datesByDate)
for dates2 in datesByDate {
    print(dates2.key)
}

let groupedDates = Dictionary(grouping: dates) {
    (date) -> Int in // setting Input parameter and output type
    return date // return 'code', dot syntax can be used also
}
print(groupedDates)

class Solution {
    func numJewelsInStones(_ J: String, _ S: String) -> Int {
        var output = 0
        for (eT) in J {
            for (eS) in S {
                if eS == eT {
                    output += 1
                }
            }
        }
        return output
    }
}
let solution = Solution()
solution.numJewelsInStones("aA", "aAAbbbb")

var a = [1,2,3]

// Get the size of the array

let size = a.count
print(size)

for i in 0..<5 {
    print(i)
}

//Here I’m creating the calendar instance that we will operate with:
let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)

//Now asking the calendar what month are we in today’s date:
let currentMonthInt = (calendar?.component(NSCalendar.Unit.month, from: Date()))!
var savedMonth = currentMonthInt
if savedMonth != currentMonthInt {
    savedMonth = currentMonthInt
    // resetData
} else {
    // don't resetData
}
