// The Swift Programming Language
// https://docs.swift.org/swift-book
// Music Instrument rental
import Foundation

/*
TODO!
- Instruments, alavalble stock, amount being repaired, price
- Purchaser list
- Orders

- put in hard data, make a toggle in code to enable/disable
*/


/// Instruments
struct Instrument {
    let id: Int
    var type: String
    let price: Double
    var totalStock: Int
    var rented: Int
    var broken: Int
}

struct Purchaser {
    let id: Int
    var name: String
    var phoneNum: String
    var email: String
    var adress: String
}

struct Order {
    let id: Int
    let purchaserID: Int
    ///formatted as [[item, amount],[item, amount]]
    let order: [String]
}



@main
struct SwiftPlayground {
    static func main() {
        mainMenu()

        func mainMenu() {
            while true {
                print("""
                Welcome to Onslow Instrument Hire!
                1. Stock management
                2. Order management
                3. Customer management
                4. Exit program
                Please type the number of your desired option.
                """, terminator: " ")

                switch readLine() {
                    case "1": print("Stock management")
                    case "2": print("Order management")
                    case "3": print("Customer management")
                    case "4": quit()
                    default: print("Please enter one of the options listed.\n")
                }
            }
        }

        //

        func quit() {
            print("Exiting.")
            exit(0)
        }
    }
}
