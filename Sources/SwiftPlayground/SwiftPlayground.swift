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
catagory for amps and stuff and ask user if they want an amp if theyre hiring an eletric gutair
*/


/// Instrument type and stock
struct Instrument {
    // i keep id for list printing. Its simpler to me
    var id: Int
    var name: String
    var totalStock: Int
    var rented: Int
    var broken: Int
    var family: Int

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
            return("\(id+1). \(name) has \(totalStock - rented - broken) avalable currently, \(rented) rented,  \(broken) broken units & is a \(instType[family])")
        } else if totalOrAval == "total" {
            return("\(id+1). \(name) has \(totalStock) total, \(rented) rented & \(broken) broken units")
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
        var selIndex = -1
        //var counter = 0
        /// misspelt as continue is a default var
        var contin = false

        var instType = ["Plucked string", "Bowed string", "Piano", "Brass", "Woodwind", "Percussion"]

        var instruments = [
            Instrument(id: 0, name: "Acoustic Guitar", totalStock: 20, rented: 4, broken: 1, family: 1),
            Instrument(id: 1, name: "Electric Guitar", totalStock: 6, rented: 1, broken: 0, family: 1)]

        //var tempInst: [Any] = [-1, "TEMP", -1, -1, -1, -1]
        var tempInst = Instrument(id: -1, name: "TEMP", totalStock: -1, rented: -1, broken: -1, family: -1)
        // used to reset back to default
        let instDefault = Instrument(id: -1, name: "TEMP", totalStock: -1, rented: -1, broken: -1, family: -1)


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
                    case "3": addInstrument()
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
            //selIndex = readLine()!
            userText = readLine()!
            if typeCheck(inputSTR: userText, type: "Int") == true {
                if Int(userText)! > 0 && Int(userText)! < (instruments.count + 1) {
                    selIndex = Int(userText)! - 1
                    tempInst = instDefault
                    tempInst.id = selIndex
                    tempInst.rented = instruments[selIndex].rented

                    contin = false
                    while contin == false {
                        print ("\nPlease enter a new name. Leave blank to leave it as \(instruments[selIndex].name).")
                        userText = readLine()!
                        if userText == "" {
                            tempInst.name = instruments[selIndex].name
                            contin = true
                        } else if userText.count > maxName {
                            print("Name too long. Must be under \(maxName + 1) characters.")
                        } else {
                            tempInst.name = userText
                            //instruments[selIndex].name = userText
                            contin = true
                        }
                    }

                    contin = false
                    while contin == false {
                        print ("\nPlease enter a new amount of broken units. Leave blank to leave it as \(instruments[selIndex].broken).")
                        userText = readLine()!
                        if userText == "" {
                            tempInst.broken = instruments[selIndex].broken
                            contin = true
                        } else if typeCheck(inputSTR: userText, type: "Int") == false {
                            print ("Please enter a whole positive number.")
                        } else if typeCheck(inputSTR: userText, type: "Int") == true {
                            if Int(userText)! >= 0 {
                                if Int(userText)! > (instruments[selIndex].totalStock - instruments[selIndex].rented) {
                                    print ("Cannot enter number higher than total avalable stock (\(instruments[selIndex].totalNotRented))")
                                } else {
                                    tempInst.broken = Int(userText)!
                                    //instruments[selIndex].broken = Int(userText)!
                                    contin = true
                                }
                            } else if Int(userText)! < 0 {
                                print ("Please enter a whole positive number.")
                            }
                        }
                    }

                    contin = false
                    while contin == false {
                        print ("\nPlease enter a new total stock amount. Leave blank to leave it as \(instruments[selIndex].totalStock).")
                        userText = readLine()!
                        if userText == "" {
                            tempInst.totalStock = instruments[selIndex].totalStock
                            contin = true
                        } else if typeCheck(inputSTR: userText, type: "Int") == false {
                            print ("Please enter a whole positive number.")
                        } else if typeCheck(inputSTR: userText, type: "Int") == true {
                            if Int(userText)! - instruments[selIndex].totalUnavalable >= 0 {
                                tempInst.totalStock = Int(userText)!
                                //instruments[selIndex].totalStock = Int(userText)!
                                contin = true
                            } else {
                                print("New stock cannot be below 0 or total unavalable units. (\(instruments[selIndex].totalUnavalable))")
                            }
                        }
                    }

                    contin = false
                    while contin == false {
                        print("\nPlease enter a new family type. Leave blank to leave it as \(instruments[selIndex].family).")
                        listFamilies()
                        //print("Leave blank to leave as \(instruments[selIndex].family).\nNew family:", terminator: " ")
                        userText = readLine()!
                        if userText == "" {
                            tempInst.family = instruments[selIndex].family
                            contin = true
                        } else if typeCheck(inputSTR: userText, type: "Int") == false {
                            print ("Please enter a whole positive number.")
                        } else if typeCheck(inputSTR: userText, type: "Int") == true {
                            if Int(userText)! <= 0 || Int(userText)! > instType.count {
                                print ("Please enter a valid entry.")
                            } else {
                                tempInst.family = Int(userText)!
                                contin = true
                            }
                        }
                    }

                } else {
                    print("Please enter a valid entry.")
                }
            } else {
                print("Please enter a valid entry.")
            }

            contin = false
            print("\n\(tempInst.instrumentSummary(totalOrAval: "total"))")
            print("Confirm your changes? Y/n")
            while contin == false {
                userText = readLine()!
                if userText.lowercased() == "y" || userText == "" {
                    print("change")
                    contin = true
                } else if userText.lowercased() == "n" {
                    print("discard")
                    contin = true
                } else {
                    print("Please enter Y/n")
                }
            }
            //print("DEBUG \(instruments[0].instrumentSummary(totalOrAval: "avalable"))")
        }


        func addInstrument() {
            print("\nCreating a new instrument")
            contin = false
            while contin == false {
                print("Name:", terminator: " ")
                userText = readLine()!
                if userText.count == 0 || userText.count > maxName {
                    print("Name must be between 0 and \(maxName + 1) characters\n")
                } else {
                    tempInst.name = userText
                    contin = true
                }
            }
            contin = false
            while contin == false {
                print("Stock:", terminator: " ")
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    if Int(userText)! >= 0 {
                        tempInst.totalStock = Int(userText)!
                    } else {
                        print("Stock must be a positive whole number")
                    }
                } else {
                    print("Stock must be a positive whole number")
                }
            }
            print(tempInst)

            //make confirm screen beofre it saves, ask if user is sure they want one with 0 stock (if 0)
        }


        func typeCheck(inputSTR: String, type: String) -> Bool{
            if type == "Int" {
                if let _ = Int(inputSTR) {
                    return true
                } else {
                    return false
                }
            }
            if type == "Double" { // since removed price double is unused. Keeping it here incase needed
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

        func listFamilies() {
            for (index, item) in instType.enumerated() {
                print("\(index + 1). \(item)")
            }
        }


        func quit() {
            print("Exiting.")
            exit(0)
        }
    }
}
