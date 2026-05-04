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

round(value * 100) / 100.0
*/


/// Instrument type and stock
struct Instrument {
    let id: Int
    var type: String
    var totalStock: Int
    var rented: Int
    var broken: Int

    /// calculates the total stock including broken, minus rented
    var totalNotRented: Int {
        return totalStock - rented
    }

    var totalUnavalable: Int {
        return rented + broken
    }

    func instrumentSummary(totalOrAval: String) -> String {
        //return("\(id+1). A \(type) costs $\(price) per day. We have \(totalStock - rented - broken) avalable, \(rented) rented & \(broken) broken units")
        if totalOrAval == "avalable" {
            return("\(id+1). \(type) has \(totalStock - rented - broken) avalable currently, \(rented) rented & \(broken) broken units")
        } else if totalOrAval == "total" {
            return("\(id+1). \(type) has \(totalStock) total, \(rented) rented & \(broken) broken units")
        } else {
            print("CODE ERROR. instrumentSummary() passed incorrect information.")
            return("")
        }
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
        let maxName = 40
        var userText = ""
        var selIndex = ""
        //var counter = 0
        /// misspelt as continue is a default var
        var contin = false

        var instruments = [
            Instrument(id: 0, type: "Acoustic Guitar", totalStock: 20, rented: 4, broken: 1),
            Instrument(id: 1, type: "Electric Guitar", totalStock: 6, rented: 1, broken: 0)]

        //let instProp = ["id", "name", "price", "total stock", "rented", "broken"]


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
                print((item.instrumentSummary(totalOrAval: "avalable")))
            }
            print()
        }

        func modifyInstrument() {
            print("\nNote: The total rented cannot be edited though this.")
            print("Please type the number for the instrument you want to modify")
            for item in instruments {
                print((item.instrumentSummary(totalOrAval: "total")))
            }
            selIndex = readLine()!
            if typeCheck(inputSTR: selIndex, type: "Int") == true {
                if Int(selIndex)! > 0 && Int(selIndex)! < (instruments.count + 1) {
                    contin = false
                    while contin == false {
                        print ("\nPlease enter a new name. Leave blank to leave it as \(instruments[Int(selIndex)! - 1].type).")
                        userText = readLine()!
                        if userText == "" {
                            contin = true
                        } else if userText.count > maxName {
                            print("Name too long. Must be under \(maxName + 1) characters.")
                        }
                        else {
                            instruments[Int(selIndex)! - 1].type = userText
                            contin = true
                        }
                    }

                    contin = false
                    while contin == false {
                        print ("\nPlease enter a new amount of broken units. Leave blank to leave it as \(instruments[Int(selIndex)! - 1].broken).")
                        userText = readLine()!
                        if userText == "" {
                            contin = true
                        } else if typeCheck(inputSTR: userText, type: "Int") == false {
                            print ("Please enter a whole positive number.")
                        } else if typeCheck(inputSTR: userText, type: "Int") == true {
                            if Int(userText)! >= 0 {
                                if Int(userText)! > (instruments[Int(selIndex)! - 1].totalStock - instruments[Int(selIndex)! - 1].rented) {
                                    print ("Cannot enter number higher than total avalable stock (\(instruments[Int(selIndex)! - 1].totalNotRented))")
                                } else {
                                    instruments[Int(selIndex)! - 1].broken = Int(userText)!
                                    contin = true
                                }
                            } else if Int(userText)! < 0 {
                                print ("Please enter a whole positive number.")
                            }
                        }
                    }

                    contin = false
                    while contin == false {
                        print ("\nPlease enter a new total stock amount. Leave blank to leave it as \(instruments[Int(selIndex)! - 1].totalStock).")
                        userText = readLine()!
                        if userText == "" {
                            contin = true
                        } else if typeCheck(inputSTR: userText, type: "Int") == false {
                            print ("Please enter a whole positive number.")
                        } else if typeCheck(inputSTR: userText, type: "Int") == true {
                            if Int(userText)! - instruments[Int(selIndex)! - 1].totalUnavalable >= 0 {
                                instruments[Int(selIndex)! - 1].totalStock = Int(userText)!
                                contin = true
                            } else {
                                print("New stock cannot be below 0 or total unavalable units. (\(instruments[Int(selIndex)! - 1].totalUnavalable))")
                            }
                        }
                    }

                } else {
                    print("Please enter a valid entry.")
                }
            } else {
                print("Please enter a valid entry.")
            }
            //print("DEBUG \(instruments[0].instrumentSummary(totalOrAval: "avalable"))")
        }


// this is just an idea to see if making this into 1 function is cleaner
// !!!!!!!!! how to use string as input in place of .type
        func instEdit(action: String, instIndex: Int, cell: String, inputType: String) {
            if action == "Modify" {
                //print("Please enter the new  for \(instruments[instIndex].cell)")
            }
        }



        func typeCheck(inputSTR: String, type: String) -> Bool{
            if type == "Int" {
                if let _ = Int(inputSTR) {
                    return true
                } else {
                    return false
                }
            }
            if type == "Double" {
                if let _ = Double(inputSTR) {
                    return true
                } else {
                    return false
                }
            } else {
                print("CODE ERROR. Incorrect type supplied to typeCheck()")
                return false
            }
        }


        func quit() {
            print("Exiting.")
            exit(0)
        }
    }
}
