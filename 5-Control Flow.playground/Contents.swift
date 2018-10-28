//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let minutes = 60
var ticks = 0
for tickmark in 0..<minutes { //use ..< to include the lower bound
    print(tickmark) //render tickmark each minute(60 times)
}
let minuteInterval = 5
for tickmark in stride(from: 0,to: minutes,by:minuteInterval) { //use stride(from:to:by:)
    print(tickmark)
}
for tickmark in stride(from: 0,through: minutes,by:minuteInterval) { //use stride(from:through:by:)
    print(tickmark)
}

