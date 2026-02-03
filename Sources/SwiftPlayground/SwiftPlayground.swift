// The Swift Programming Language
// https://docs.swift.org/swift-book


func totalCost(prices: [Double]) -> Double {
    var totalCost1 = 0.0
    for i in prices{
        totalCost1 += i
    }
    return totalCost1
}

@main
struct SwiftPlayground {
    static func main() {
        let lunches = [6.50, 8.00, 5.75, 9.20, 7.10]
        var day = 0
        //var totalCost = 0.0
        for i in lunches{
            //totalCost = totalCost + i
            day = day + 1
            print("Day \(day): $\(i)")
        }


        print ("Total cost: $\(totalCost(prices: lunches))")
    }
}
