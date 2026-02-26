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
    func toFarenheit(celcius: Double) -> Double {

    }
    func toelcius(farenheit: Double) -> Double {
        
    }
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
    }
}
