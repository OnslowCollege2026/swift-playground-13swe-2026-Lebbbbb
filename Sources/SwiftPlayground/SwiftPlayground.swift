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


/// Instrument type and stock
struct Instrument {
    let id: Int
    var type: String
    let price: Double
    var totalStock: Int
    var rented: Int
    var broken: Int

    func instrumentSummary() -> String {
        //return("\(id+1). A \(type) costs $\(price) per day. We have \(totalStock - rented - broken) avalable, \(rented) rented & \(broken) broken units")
        return("\(id+1). \(type) costs $\(price) per day. \(totalStock - rented - broken) avalable, \(rented) rented & \(broken) broken units")
    }
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
        var userText = ""

        var instruments = [
            Instrument(id: 0, type: "Acoustic Guitar", price: 10.0, totalStock: 20, rented: 4, broken: 1),
            Instrument(id: 1, type: "Electric Guitar", price: 25, totalStock: 6, rented: 1, broken: 0)]




        mainMenu()

        func mainMenu() {
            while true {
                print("""
                \nWelcome to Onslow Instrument Hire!
                1. Stock management
                2. Order management
                3. Customer management
                4. Exit program
                Please type the number of your desired option.
                """, terminator: " ")

                switch readLine() {
                    case "1": stockManagement()
                    case "2": print("Order management")
                    case "3": print("Customer management")
                    case "4": quit()
                    default: print("Please enter one of the options listed.\n")
                }
            }
        }



        func stockManagement() {
            while true {
                print("""
                \nStock management
                1. Stock summary
                2. Modify existing instrument
                3. Add new instrument
                4. Remove instrument
                5. Return
                Please type the number of your desired option.
                """, terminator: " ")

                switch readLine() {
                    case "1": stockSummary()
                    case "2": modifyInstrument()
                    case "3": print("Add new instrument")
                    case "4": print("Remove instrument")
                    case "5": mainMenu()
                    default: print("Please enter one of the options listed.\n")
                }
            }
        }

        func stockSummary() {
            print("\nStock summary.")
            for item in instruments {
                print((item.instrumentSummary()))
            }
            print()
        }

        func modifyInstrument() {
            print("Please type the number for the instrument you want to modify")
            for item in instruments {
                print((item.instrumentSummary()))
            }
            userText = readLine()!
            if Int(userText)! > 0 && Int(userText)! < (instruments.count + 1) {
                print ("VALID")
            } else {
                print("INVALID")
            }
        }



        func intChecker(inputSTR: String) -> Bool{
            if let Int(inputSTR) {

            }
        }


        func quit() {
            print("Exiting.")
            exit(0)
        }
    }
}
