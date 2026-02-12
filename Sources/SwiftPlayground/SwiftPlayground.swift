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

        print("\nTASKS BELOW:")

        // Task 1
        let numbers2 = [7, 14, 21, 28, 35]
        // Finds total of numbers2
        let numbers2Total = numbers2.reduce(0) { $0 + $1 }
        print (numbers2Total)

        // Task 2
        let words = ["apple", "banana", "grape", "strawberry", "kiwi"]
        // Finds longest word
        let wordsLongest = words.reduce("") { 
            if $0.count > $1.count { // if starting value is shorter, return shorter
                return $0
            }
            else{
                return $1
            }
        }
        print (wordsLongest)
        print ("\nTask 3")

        // Task 3 Analyzing Students Scores
        let scores = [45, 78, 89, 32, 50, 92, 67, 41, 99, 56]
        // Finds scores + 5 and filters below 50
        let scoresFilter = scores
        .map { $0 + 5 }
        .filter {$0 >= 50}
        // Find average
        let scoresAverage = scoresFilter
        .reduce(0) { $0 + $1 } / (scoresFilter.count)
        print (scoresAverage)

        //print("\nOther Closures")
    }
}
