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
!!!!!!!!!!!!!!!!!ONCE CREATED HIRING SYSTEM when modifying stock/removing instrument check if there are any current hires

cannot delete old records as will break loaning system sadly
AAH!!!!!! using .count doesnt work if an item can be deleted cause then the ID's will be off...
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

    var totalAval: Int {
        return totalStock - rented - broken
    }

    var totalUnavalable: Int {
        return rented + broken
    }
    var instType = ["Plucked string", "Bowed string", "Piano", "Brass", "Woodwind", "Percussion"]

    func instrumentSummary(totalOrAval: String) -> String {
        //return("\(id+1). A \(type) costs $\(price) per day. We have \(totalStock - rented - broken) avalable, \(rented) rented & \(broken) broken units")
        if totalOrAval == "avalable" {
            return("\(id+1). \(name) has \(totalStock - rented - broken) avalable currently, \(rented) rented,  \(broken) broken units & is a \(instType[family])")
        } else if totalOrAval == "total" {
            return("\(id+1). \(name) has \(totalStock) total, \(rented) rented, \(broken) broken units & is a \(instType[family])")
        } else {
            print("CODE ERROR. instrumentSummary() passed incorrect information.")
            return("")
        }
    }
}

struct User {
    var id: Int
    var name: String
    var email: String
    //var phoneNum: String
    //var adress: String

    // func userSum() -> String {
    //     return("\(id+1). \(name), \(email) has  loans")
    // }
}

struct Loan {
    var id: Int
    var userID: Int
    var itemID: Int
    var returned: Bool


}



@main
struct SwiftPlayground {
    static func main() {
        let maxInstName = 40
        let maxUserName = 40
        var userText = ""
        var selIndex = -1
        var selIndex1 = -1
        //var counter = 0
        /// misspelt as continue is a default var
        var contin = false

        //var instType = ["Plucked string", "Bowed string", "Piano", "Brass", "Woodwind", "Percussion"]

        var instruments = [
            Instrument(id: 0, name: "Acoustic Guitar", totalStock: 20, rented: 4, broken: 1, family: 0),
            Instrument(id: 1, name: "Electric Guitar", totalStock: 6, rented: 1, broken: 0, family: 0),
            Instrument(id: 2, name: "Grand Piano", totalStock: 0, rented: 0, broken: 0, family: 2)]

        //var tempInst: [Any] = [-1, "TEMP", -1, -1, -1, -1]
        var tempInst = Instrument(id: -1, name: "", totalStock: 0, rented: 0, broken: 0, family: 0)
        // used to reset back to default
        let instDefault = Instrument(id: -1, name: "", totalStock: 0, rented: 0, broken: 0, family: 0)

        var tempUser = User(id: 0, name: "", email: "")

        var users = [
            User(id: 0, name: "Leb", email: "leb@leb.com"),
            User(id: 1, name: "Millie", email: "millie@millie.com"),
            User(id: 2, name: "Phoebe", email: "phoebe@phoebe.com")]

        var loans = [
            Loan(id: 0, userID: 0, itemID: 1, returned: false),
            Loan(id: 1, userID: 0, itemID: 0, returned: false),
            Loan(id: 2, userID: 1, itemID: 1, returned: true),
            Loan(id: 3, userID: 0, itemID: 0, returned: false)
        ]

        mainMenu()

        ///MARK: == Main Menu ==
        func mainMenu() {
            while true {
                print("""
                \nWelcome to Onslow Instrument Hire!
                1. Stock management
                2. Order management
                3. User management
                4. Exit program
                Please type the number of your desired option.
                """, terminator: " ")

                switch readLine() {
                    case "1": stockManagement()
                    case "2": orderManagement()
                    case "3": userManagement()
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


        // MARK: Modify inst
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
                        } else if userText.count > maxInstName {
                            print("Name too long. Must be under \(maxInstName + 1) characters.")
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
                            if Int(userText)! <= 0 || Int(userText)! > tempInst.instType.count {
                                print ("Please enter a valid entry.")
                            } else {
                                tempInst.family = Int(userText)! - 1
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
                    instruments[selIndex] = tempInst
                    print("Instrument modified.")
                    contin = true
                } else if userText.lowercased() == "n" {
                    print("Modification discarded.")
                    contin = true
                } else {
                    print("Please enter Y/n")
                }
            }
            //print("DEBUG \(instruments[0].instrumentSummary(totalOrAval: "avalable"))")
        }


        // MARK: Add inst
        func addInstrument() {
            print("\nCreating a new instrument")
            tempInst = instDefault
            tempInst.id = instruments.count
            contin = false
            while contin == false {
                print("Name:", terminator: " ")
                userText = readLine()!
                if userText.count == 0 || userText.count > maxInstName {
                    print("Name must be between 0 and \(maxInstName + 1) characters\n")
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
                        contin = true
                    } else {
                        print("Stock must be a positive whole number")
                    }
                } else {
                    print("Stock must be a positive whole number")
                }
            }

            contin = false
            while contin == false {
                print("Broken units:", terminator: " ")
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    if Int(userText)! >= 0 && Int(userText)! <= tempInst.totalStock {
                        tempInst.broken = Int(userText)!
                        contin = true
                    } else {
                        print("Must be a positive whole number & not above total stock.")
                    }
                } else {
                    print("Must be a positive whole number & not above total stock.")
                }
            }

            contin = false
            while contin == false {
                listFamilies()
                print("Family type:", terminator: " ")
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    if Int(userText)! <= 0 || Int(userText)! > tempInst.instType.count {
                        print("Please enter a valid entry")
                    } else {
                        tempInst.family = Int(userText)! - 1
                        contin = true
                    }
                } else {
                    print("Please enter a valid entry")
                }
            }
            
            print("\n\(tempInst.instrumentSummary(totalOrAval: "total"))")
            print("Would you like to create this instrument? Y/n")
            contin = false
            while contin == false {
                userText = readLine()!
                if userText.lowercased() == "y" || userText == "" {
                    instruments.append(tempInst)
                    print("Instrument created.")
                    contin = true
                } else if userText.lowercased() == "n" {
                    print("Creation discarded.")
                    contin = true
                } else {
                    print("Please enter Y/n")
                }
            }
        }



        //MARK: == Loan mgmt ==
        func orderManagement() {
            while true {
                print("""
                \nLoan Management
                1. Search loans
                2. New loan
                3. Return loan
                4. Prune loans
                5. Return
                Please type the number of your desired option.
                """, terminator: " ")

                switch readLine() {
                    case "1": searchLoans()
                    case "2": newLoan()
                    case "3": returnLoan()
                    case "4": print("4")
                    case "5": mainMenu()
                    default: print("Please enter one of the options listed.\n")
                }
            }
        }

        func loanSum(lID: Int, yellIfReturned: Bool) -> String {
            if yellIfReturned == true {
                if loans[lID].returned == true {
                    return("ID: \(loans[lID].id) held by \(users[loans[lID].id].name) has been returned.")
                } else {
                    return("ID: \(loans[lID].id) held by \(users[loans[lID].id].name) has NOT been returned.")
                }
            } else {
                return("ID: \(loans[lID].id) held by \(users[loans[lID].id].name) took out a \(instruments[loans[lID].itemID].name).")
            }
        }


        ///MARK: Search Loans
        func searchLoans() {
            print("""
            \nSearch loans
            1. List all current
            2. List from user
            3. Return
            """)
            switch readLine() {
                case "1": listCurrent()
                case "2": listFromUser()
                case "3": orderManagement()
                default: print("Please enter one of the options listed.\n")
            }
        }

        func listCurrent() {
            print("\nCurrent loans:")
            let notReturned = loans.filter { $0.returned == false }
            for loan in notReturned {
                print("ID: \(loan.id) held by \(users[loan.userID].name) who took out a \(instruments[loan.itemID].name).")
            }
        }

        func listFromUser() {
            print("\nList from user")
            userSummary(uID: -1)
            contin = false
            while contin == false {
                print("Enter the user ID you want to search: ", terminator: "")
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    if Int(userText)! <= 0 || Int(userText)! > users.count {
                        print("")
                    } else {
                        selIndex = Int(userText)! - 1
                        contin = true
                    }
                } else {
                    print("")
                }
            }

            print("\nSelected \(users[selIndex].name)")
            let userInspection = loans.filter { $0.userID == selIndex }
            if userInspection.count == 0 {
                print("\(users[selIndex].name) has no current or previous loans.")
            } else {
                for loan in userInspection {
                    if loan.returned == true {
                        print("ID: \(loan.id). \(users[loan.userID].name) took out a \(instruments[loan.itemID].name) and has returned it.")
                    } else {
                        print("ID: \(loan.id). \(users[loan.userID].name) took out a \(instruments[loan.itemID].name) and has NOT returned it.")
                    }
                }
            }
        }



        ///MARK: New loan
        func newLoan() {
            print("\nNew loan")
            userSummary(uID: -1)
            contin = false
            while contin == false {
                print("Enter the user ID the loan is from: ", terminator: "")
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    if Int(userText)! <= 0 || Int(userText)! > users.count {
                        print("")
                    } else {
                        selIndex = Int(userText)! - 1
                        contin = true
                    }
                } else {
                    print("")
                }
            }

            print()
            for item in instruments {
                print((item.instrumentSummary(totalOrAval: "avalable")))
            }
            contin = false
            while contin == false {
                print("Enter the instrument ID to borrow: ", terminator: "")
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    if Int(userText)! <= 0 || Int(userText)! > instruments.count {
                        print()
                    } else if instruments[Int(userText)! - 1].totalAval - 1 <= 0 {
                        print("Selected instrument must have alteast 1 avalable.")
                    }
                    else {
                        selIndex1 = Int(userText)! - 1
                        contin = true
                    }
                } else {
                    print()
                }
            }

            print("\(users[selIndex].name) borrowing \(instruments[selIndex1].name)")
            print("Would you like to confirm this loan? Y/n")
            contin = false
            while contin == false {
                userText = readLine()!
                if userText.lowercased() == "y" || userText == "" {
                    instruments[selIndex1].rented = instruments[selIndex1].rented + 1
                    loans.append(Loan(id: (loans.count), userID: selIndex, itemID: selIndex1, returned: false))
                    print("Item loaned.")
                    contin = true
                } else if userText.lowercased() == "n" {
                    print("Loan discarded.")
                    contin = true
                } else {
                    print("Please enter Y/n")
                }
            }
        }


        ///MARK: Return loan
        func returnLoan() {
            print("\nReturn loan")
            let notReturned = loans.filter { $0.returned == false }
            for loan in notReturned {
                print("ID: \(loan.id) held by \(users[loan.userID].name) who took out a \(instruments[loan.itemID].name).")
            }
            contin = false
            while contin == false {
                print("Please enter the loan ID you would like to return")
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    let notReturned = notReturned.filter { $0.id == Int(userText)! }
                    if notReturned.count != 0 {
                        selIndex = Int(userText)!
                        contin = true
                    } else {
                        print("Please enter a valid loan ID")
                    }
                } else {
                    print("Please enter a valid loan ID")
                }
            }

            print("\nID: \(loans[selIndex].id) held by \(users[loans[selIndex].userID].name) who took out a \(instruments[loans[selIndex].itemID].name).")
            print("Would you like to confirm this return? Y/n")
            contin = false
            while contin == false {
                userText = readLine()!
                if userText.lowercased() == "y" || userText == "" {
                    selIndex1 = loans[selIndex].itemID
                    instruments[selIndex1].rented = instruments[selIndex1].rented - 1
                    loans[selIndex].returned = true
                    print("Return confirmed.")
                    contin = true
                } else if userText.lowercased() == "n" {
                    print("Return discarded.")
                    contin = true
                } else {
                    print("Please enter Y/n")
                }
            }


        }



        //MARK: == User mgmt ==
        func userManagement() {
            while true {
                print("""
                \nUser Management
                1. User list
                2. Modify existing user
                3. Add new user
                4. Remove user
                5. Return
                Please type the number of your desired option.
                """, terminator: " ")

                switch readLine() {
                    case "1": userSummary(uID: -1)
                    case "2": userModify()
                    case "3": print("Add new user")
                    case "4": print("Remove user")
                    case "5": mainMenu()
                    default: print("Please enter one of the options listed.\n")
                }
            }
        }


        func userSummary(uID: Int) {
            //print()
            if uID == -1 {
                for user in users {
                    let currentLoans = loans.filter { $0.userID == user.id && $0.returned == false }
                    print("\(user.id+1). \(user.name), \(user.email) has \(currentLoans.count) current loans")
                }
            } else {
                let currentLoans = loans.filter { $0.userID == users[selIndex].id && $0.returned == false }
                print("\(users[uID].id+1). \(users[uID].name), \(users[uID].email) has \(currentLoans.count) current loans")
            }
        }


        ///MARK: User Modify
        func userModify() {
            print()
            userSummary(uID: -1)
            print("Please enter a the users ID number.")
            contin = false
            while contin == false {
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    if Int(userText)! <= 0 || Int(userText)! > users.count {
                        print("Invalid input.")
                    } else {
                        selIndex = Int(userText)! - 1
                        tempUser.id = selIndex
                        contin = true
                    }
                } else {
                    print("Invalid input.")
                }
            }

            print("Please enter a new name. Leave blank to keep as \(users[selIndex].name)")
            contin = false
            while contin == false {
                userText = readLine()!
                if userText == "" {
                    tempUser.name = users[selIndex].name
                    contin = true
                } else if userText.count < 0 && userText.count > maxUserName {
                    print("Name must be between 0 & \(maxUserName + 1) characters.")
                } else {
                    tempUser.name = userText
                    contin = true
                }
            }
            
            print("Please enter a new email. Leave blank to keep as \(users[selIndex].email)")
            contin = false
            while contin == false {
                userText = readLine()!
                if userText == "" {
                    tempUser.email = users[selIndex].email
                    contin = true
                } else {
                    tempUser.email = userText
                    contin = true
                }
            }

            print("\(tempUser.id+1). \(tempUser.name), \(tempUser.email)")
            print("Confirm these changes? Y/n")
            contin = false
            while contin == false {
                userText = readLine()!
                if userText.lowercased() == "y" || userText == "" {
                    users[selIndex] = tempUser
                    print("User modified.")
                    contin = true
                } else if userText.lowercased() == "n" {
                    print("Modification discarded.")
                    contin = true
                } else {
                    print("Please enter Y/n")
                }
            }
        }


        //MARK: Add user
        func addUser() {
            print("Add new user\nName")
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
            for (index, item) in tempInst.instType.enumerated() {
                print("\(index + 1). \(item)")
            }
        }


        func quit() {
            print("Exiting.")
            exit(0)
        }
    }
}
