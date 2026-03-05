// The Swift Programming Language
// https://docs.swift.org/swift-book
// swift run
import Foundation

struct Book {
    let title: String
    let author: String
    let pages: Int

    func summary() -> String {
        return "The book \"\(title)\" by \(author) has \(pages) pages."
    }
}

func bookSummary(title: String, author: String, pages: Int) -> String {
    return "The book \(title) by \(author) has \(pages) pages."
}

struct Temperature {
    static func toFarenheit(celcius: Double) -> Double {
        return((celcius * 9 / 5) + 32)
    }
    static func toCelsius(farenheit: Double) -> Double {
        return((farenheit - 32) * 5 / 9)
    }
}

struct Timer {
    var seconds: Int
    var isRunning: Bool

    mutating func start() {
        isRunning = true
    }

    mutating func tick() {
        if isRunning == true {
            seconds += 1
        }
    }

    mutating func reset() {
        seconds = 0
        isRunning = false
    }
}

struct Cart {
    var itemsCount: Int
    static let freeShippingThreshold = 5
}


@main
struct SwiftPlayground {
    static func main() {
        print("Task A")
        let books = [
            Book(title: "HELP MILLIE'S TRYING TO KILL ME", author: "Leb", pages: 3),
            Book(title: "Leb is a dirty liar", author: "Millie", pages: 201),
            Book(title: "Millie, a retrospective", author: "Millie", pages: 30216)
        ]
        for book in books {
            print (book.summary())
        }
        // The method ver is cleaner as its all contained inside the struct, and values dont have to be passed around

        // Task B
        print("\nTask B")
        print(Temperature.toFarenheit(celcius: 28.6))
        print(Temperature.toFarenheit(celcius: 10.0))
        print(Temperature.toCelsius(farenheit: 83.4))
        print(Temperature.toCelsius(farenheit: 56.3))

        // Task C
        print("\nTask C")
        var stopwatch = Timer(seconds: 0, isRunning: false)
        print(stopwatch)
        stopwatch.start()
        print(stopwatch)
        stopwatch.tick()
        print(stopwatch)
        stopwatch.reset()
        print(stopwatch)

        // Task D
        print("\nTask D")

    }
}
