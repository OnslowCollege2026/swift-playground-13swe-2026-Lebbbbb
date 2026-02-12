// The Swift Programming Language
// https://docs.swift.org/swift-book
// swift run

@main
struct SwiftPlayground {
    static func main() {
        let number = [1, 2, 3, 4, 5]

        // Find cubed of number
        let numberCubed = number.map { number in
            return number * number * number
        }
        print(numberCubed)

        // Find even numbers from numberCubed
        let evenNumbers = numberCubed.filter { number in
            return number % 2 == 0
        }
        print(evenNumbers)

        // Find total from evenNumbers
        let total = evenNumbers.reduce(0) { result, number in
            return result + number
        }
        print(total)


        // All above but condenced
        let total2 = number.map { number in
            return number * number * number
        }.filter { number in
            return number % 2 == 0
        }.reduce(0) { result, number in
            return result + number
        }

        print(total2)


        // Further condenced, $0 is first input and so on. Dont need return
        let total3 = number
        .map { $0 * $0 * $0 }
        .filter { $0 % 2 == 0 }
        .reduce(0) { $0 + $1 }

        print(total3)

        print("\nTASKS BELOW:\n")

        let numbers2 = [7, 14, 21, 28, 35]
        // Finds total of numbers2
        let numbers2Total = numbers2.reduce(0) { $0 + $1 }
        print (numbers2Total)

        // Task 2 FIX THIS
        let words = ["apple", "banana", "grape", "strawberry", "kiwi"]
        let wordsLongest = words.reduce("") { 
            if $0.count > $1.count { $0 = $1 } {
                
            }
        //let wordsLongest = words[1].count
        }
        print (wordsLongest)
    }
}
