// The Swift Programming Language
// https://docs.swift.org/swift-book
// Music Instrument rental
import Foundation


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

    /// prints a summary based on incoming args
    func instrumentSummary(totalOrAval: String) -> String {
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



// i ran into scope issues having the summaries in thes next 2 structs directly
struct User {
    var id: Int
    var name: String
    var email: String
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
        let maxInstName = 40 //maximum characters for an instrument name
        let maxUserName = 40 //maximum characters for a users name

        // temp variables i use
        var userText = ""
        var selIndex = -1
        var selIndex1 = -1

        /// misspelt cause continue is a default var in swift
        var contin = false

        // instrument data
        var instruments = [
            Instrument(id: 0, name: "Acoustic Guitar", totalStock: 20, rented: 2, broken: 1, family: 0),
            Instrument(id: 1, name: "Electric Guitar", totalStock: 6, rented: 2, broken: 0, family: 0),
            Instrument(id: 2, name: "Grand Piano", totalStock: 0, rented: 0, broken: 0, family: 2)]

        // user data
        var users = [
            User(id: 0, name: "Leb", email: "leb@leb.com"),
            User(id: 1, name: "Millie", email: "millie@millie.com"),
            User(id: 2, name: "Phoebe", email: "phoebe@phoebe.com")]

        //loan data
        var loans = [
            Loan(id: 0, userID: 0, itemID: 1, returned: false),
            Loan(id: 1, userID: 0, itemID: 0, returned: false),
            Loan(id: 2, userID: 1, itemID: 1, returned: true),
            Loan(id: 3, userID: 0, itemID: 0, returned: false)
        ]

        // temp arrays used for confirming changes
        var tempInst = Instrument(id: -1, name: "", totalStock: 0, rented: 0, broken: 0, family: 0)
        let instDefault = Instrument(id: -1, name: "", totalStock: 0, rented: 0, broken: 0, family: 0)
        var tempUser = User(id: 0, name: "", email: "")


        // the only non variable defining non function code. waow
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
                    case "4": removeInst()
                    case "5": mainMenu()
                    default: print("Please enter one of the options listed.\n")
                }
            }
        }


        /// prints summary of all stock
        func stockSummary() {
            print("\nStock summary.")
            for item in instruments {
                print((item.instrumentSummary(totalOrAval: "avalable")))
            }
            print()
        }


        /// MARK: Modify inst
        func modifyInstrument() {
            print("\nNote: The total rented cannot be edited though this.")
            print("Please type the number for the instrument you want to modify")
            for item in instruments {
                print((item.instrumentSummary(totalOrAval: "total")))
            }
            tempInst = instDefault
            contin = false
            // loops til valid ID selected/exited
            while contin == false {
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    // finds if user inputted a valid id
                    if (instruments.filter { $0.id == (Int(userText)! - 1) }).count == 1 {
                        selIndex = (instruments.indices.filter { instruments[$0].id == (Int(userText)! - 1) })[0]
                        tempInst.id = selIndex
                        tempInst.rented = instruments[selIndex].rented
                        contin = true
                    } else {
                        print("Please enter a valid entry.")
                    }
                } else {
                    print("Please enter a valid entry.")
                }
            }

            // new name selection
            contin = false
            while contin == false {
                print ("\nPlease enter a new name. Leave blank to leave it as \(instruments[selIndex].name).")
                userText = readLine()!
                // if text blank then keep the original name
                if userText == "" {
                    tempInst.name = instruments[selIndex].name
                    contin = true
                // name cant be over 40 characters
                } else if userText.count > maxInstName {
                    print("Name too long. Must be under \(maxInstName + 1) characters.")
                } else {
                    tempInst.name = userText
                    contin = true
                }
            }

            // new amount of broken. this is before total stock as totalstock cant be below amount of broken units
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
                        // number is invalid if there are more broken than total stock - loaned
                        if Int(userText)! > (instruments[selIndex].totalStock - instruments[selIndex].rented) {
                            print ("Cannot enter number higher than total avalable stock (\(instruments[selIndex].totalNotRented))")
                        } else {
                            tempInst.broken = Int(userText)!
                            contin = true
                        }
                    } else if Int(userText)! < 0 {
                        print ("Please enter a whole positive number.")
                    }
                }
            }

            // new total stock
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
                        contin = true
                    } else {
                        print("New stock cannot be below 0 or total unavalable units. (\(instruments[selIndex].totalUnavalable))")
                    }
                }
            }

            // new family type
            contin = false
            while contin == false {
                print("\nPlease enter a new family type. Leave blank to leave it as \(instruments[selIndex].family).")
                listFamilies()
                userText = readLine()!
                if userText == "" {
                    tempInst.family = instruments[selIndex].family
                    contin = true
                } else if typeCheck(inputSTR: userText, type: "Int") == false {
                    print ("Please enter a whole positive number.")
                } else if typeCheck(inputSTR: userText, type: "Int") == true {
                    // checks if number is out of the index
                    if Int(userText)! <= 0 || Int(userText)! > tempInst.instType.count {
                        print ("Please enter a valid entry.")
                    } else {
                        // -1 like most things ive done, the ID's get printed at +1
                        tempInst.family = Int(userText)! - 1
                        contin = true
                    }
                }
            }

            // asks user if they want to confirm the changes
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
        }


        // MARK: Add inst
        func addInstrument() {
            print("\nCreating a new instrument")
            tempInst = instDefault
            tempInst.id = instruments.endIndex
            contin = false
            // Asks for name
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
            // Asks for stock count
            contin = false
            while contin == false {
                print("Stock:", terminator: " ")
                userText = readLine()!
                // checks if input is an int
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
            // Asks for amount of broken units
            contin = false
            while contin == false {
                print("Broken units:", terminator: " ")
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    // if the input isnt above the total stock then it continues
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
            // asks for instrument family type
            contin = false
            while contin == false {
                listFamilies()
                print("Family type:", terminator: " ")
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    // checks if its a valid index in the family types
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
            
            // confirm with user if they want to create this instrument
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


        //MARK: Remove inst
        func removeInst() {
            print("\nRemove instrument. Enter a blank field to exit.")
            // print all instruments
            for item in instruments {
                print((item.instrumentSummary(totalOrAval: "total")))
            }
            contin = false
            while contin == false {
                print("ID of instrument to remove: ", terminator: "")
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    // checks if the user input is a valid id
                    if (instruments.filter { $0.id == (Int(userText)! - 1) }).count == 1 {
                        selIndex = (instruments.indices.filter { instruments[$0].id == (Int(userText)! - 1) })[0]
                        // checks if the selected instrument has any loans logged
                        if instruments[selIndex].rented > 0 {
                            print("Cannot remove instrument with active loans. Please return item(s) & prune logs before trying again.")
                        } else {
                            contin = true
                        }
                    } else {
                        print("Please select a valid id.")
                    }
                } else if userText.count == 0{
                    return
                } else {
                    print("Please select a valid id.")
                }
            }

            // asks user for confirmation if theyd like to remove the instrument
            print("\n\(instruments[selIndex].instrumentSummary(totalOrAval: "total"))")
            print("Are you sure you want to delete this instrument? Y/n")
            contin = false
            while contin == false {
                userText = readLine()!
                if userText.lowercased() == "y" || userText == "" {
                    instruments.remove(at: selIndex)
                    print("Instrument removed.")
                    contin = true
                } else if userText.lowercased() == "n" {
                    print("Removal discarded.")
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
                    case "4": pruneLoans()
                    case "5": mainMenu()
                    default: print("Please enter one of the options listed.\n")
                }
            }
        }


        ///MARK: Search Loans
        func searchLoans() {
            print("""
            \nSearch loans
            1. List all current
            2. List from user
            3. List from instrument
            4. Return
            """)
            switch readLine() {
                case "1": listCurrent()
                case "2": listFromUser()
                case "3": listFromInst()
                case "4": orderManagement()
                default: print("Please enter one of the options listed.\n")
            }
        }

        // lists current non returned loans
        func listCurrent() {
            print("\nCurrent loans:")
            let notReturned = loans.filter { $0.returned == false }
            for loan in notReturned {
                print("ID: \(loan.id) held by \(users[loan.userID].name) who took out a \(instruments[loan.itemID].name).")
            }
        }


        // lists loans from spesific user
        func listFromUser() {
            print("\nList from user")
            userSummary(uID: -1)
            // generic user selection code, same as previous instances
            contin = false
            while contin == false {
                print("Enter the user ID you want to search: ", terminator: "")
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    if (users.filter { $0.id  == (Int(userText)! - 1) }).count == 1 {
                        selIndex = (users.indices.filter { users[$0].id == (Int(userText)! - 1) })[0]
                        contin = true
                    } else {
                        print("Please select a valid user ID.")
                    }
                } else {
                    print("Please select a valid user ID.")
                }
            }

            print("\nSelected \(users[selIndex].name)")
            // filters down to only the loans the user has taken
            let userInspection = loans.filter { $0.userID == selIndex }
            // if user has no loans logged it states that
            if userInspection.count == 0 {
                print("\(users[selIndex].name) has no logged loans.")
            } else {
                for loan in userInspection {
                    // different print message if loan has/hasnt been returned
                    if loan.returned == true {
                        print("ID: \(loan.id). \(users[loan.userID].name) took out a \(instruments[loan.itemID].name) and has returned it.")
                    } else {
                        print("ID: \(loan.id). \(users[loan.userID].name) took out a \(instruments[loan.itemID].name) and has NOT returned it.")
                    }
                }
            }
        }



        // Lists all loans from spesific instrument. very simelar code to previous.
        func listFromInst() {
            print("Please type the number for the instrument you want to search")
            for item in instruments {
                print((item.instrumentSummary(totalOrAval: "total")))
            }
            // generic instrument selection code
            contin = false
            while contin == false {
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    if (instruments.filter { $0.id == (Int(userText)! - 1) }).count == 1 {
                        selIndex = (instruments.indices.filter { instruments[$0].id == (Int(userText)! - 1) })[0]
                        tempInst.id = selIndex
                        tempInst.rented = instruments[selIndex].rented
                        contin = true
                    } else {
                        print("Please enter a valid entry.")
                    }
                } else {
                    print("Please enter a valid entry.")
                }
            }
            
            print("\nSelected: \(instruments[selIndex].name)")
            let instInspection = loans.filter { $0.itemID == selIndex }
            if instInspection.count == 0 {
                print("\(instruments[selIndex].name) has no logged loans.")
            }
            for loan in instInspection {
                if loan.returned == true {
                    print("ID: \(loan.id). \(users[loan.userID].name) took out a \(instruments[loan.itemID].name) and has returned it.")
                } else {
                    print("ID: \(loan.id). \(users[loan.userID].name) took out a \(instruments[loan.itemID].name) and has NOT returned it.")
                }
            }
        }




        ///MARK: New loan
        func newLoan() {
            print("\nNew loan")
            userSummary(uID: -1)
            // generic user id selection
            contin = false
            while contin == false {
                print("Enter the user ID the loan is from: ", terminator: "")
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    if (users.filter { $0.id == (Int(userText)! - 1) }).count == 1 {
                        selIndex = (users.indices.filter { users[$0].id == (Int(userText)! - 1) })[0]
                        contin = true
                    } else {
                        print("Please enter a valid id.")
                    }
                } else {
                    print("Please enter a valid id.")
                }
            }

            print()
            // prints all instruments
            for item in instruments {
                print((item.instrumentSummary(totalOrAval: "avalable")))
            }
            contin = false
            while contin == false {
                print("Enter the instrument ID to borrow: ", terminator: "")
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    // checks if selection is in index
                    if Int(userText)! <= 0 || Int(userText)! > instruments.count {
                        print("Selected instrument must have alteast 1 avalable.  Enter a blank field to exit.")
                    // doesnt select instrument if it doesnt have any avalable
                    } else if instruments[Int(userText)! - 1].totalAval <= 0 {
                        print("Selected instrument must have alteast 1 avalable.  Enter a blank field to exit.")
                    } else {
                        selIndex1 = Int(userText)! - 1
                        contin = true
                    }
                } else if userText.count == 0 {
                    return
                } else {
                    print()
                }
            }
            // confirms if user wants to confirm the loan
            print("\(users[selIndex].name) borrowing \(instruments[selIndex1].name)")
            print("Would you like to confirm this loan? Y/n")
            contin = false
            while contin == false {
                userText = readLine()!
                if userText.lowercased() == "y" || userText == "" {
                    // adds 1 to instruments being loaned
                    instruments[selIndex1].rented = instruments[selIndex1].rented + 1
                    // logs loan in the array
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
            // prints all non reutnred loans
            for loan in notReturned {
                print("ID: \(loan.id) held by \(users[loan.userID].name) who took out a \(instruments[loan.itemID].name).")
            }
            // ID selection below
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
                        print("Please enter a valid non-returned loan ID")
                    }
                } else {
                    print("Please enter a valid loan ID")
                }
            }
            // user confirmation
            print("\nID: \(loans[selIndex].id) held by \(users[loans[selIndex].userID].name) who took out a \(instruments[loans[selIndex].itemID].name).")
            print("Would you like to confirm this return? Y/n")
            contin = false
            while contin == false {
                userText = readLine()!
                if userText.lowercased() == "y" || userText == "" {
                    // selindex1 used for the itemID
                    selIndex1 = loans[selIndex].itemID
                    // removes from total rented
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


        //MARK: Prune loans
        func pruneLoans() {
            print("\nPrune loans")
            // gets all loans that have been returned
            let returnedLoans = loans.indices.filter { loans[$0].returned == true }
            if returnedLoans.count == 0 {
                print("All loans have been returned.")
            } else {
                for loan in returnedLoans {
                    print("ID: \(loans[loan].id). \(users[loans[loan].userID].name) took out a \(instruments[loans[loan].itemID].name)")
                }

                // not Y/n to prevent potential user error
                print("Would you like to delete all returned logs? y/n\nTHIS ACTION CAN NOT BE REVERSED")
                contin = false
                while contin == false {
                    userText = readLine()!
                    if userText.lowercased() == "y" {
                        // removes all returned loans
                        for loan in returnedLoans {
                            loans.remove(at: loan)
                        }
                        print("Deleted returned loans.")
                        contin = true
                    } else if userText.lowercased() == "n" {
                        print("Operation cancelled")
                        contin = true
                    } else {
                        print("Please enter y/n")
                    }
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
                    case "3": addUser()
                    case "4": removeUser()
                    case "5": mainMenu()
                    default: print("Please enter one of the options listed.\n")
                }
            }
        }


        func userSummary(uID: Int) {
            // if uID = -1 then it prints summary for all users. otherwise it uses uID as the user ID to get the summary for
            if uID == -1 {
                for user in users {
                    // gets total current loans of the selected user
                    let currentLoans = loans.filter { $0.userID == user.id && $0.returned == false }
                    print("\(user.id+1). \(user.name), \(user.email) has \(currentLoans.count) current loans")
                }
            } else {
                // gets total current loans of the selected user
                let currentLoans = loans.filter { $0.userID == users[selIndex].id && $0.returned == false }
                print("\(users[uID].id+1). \(users[uID].name), \(users[uID].email) has \(currentLoans.count) current loans")
            }
        }


        ///MARK: User Modify
        func userModify() {
            print()
            userSummary(uID: -1)
            print("Please enter a users ID number.")
            // generic select user code
            contin = false
            while contin == false {
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    if (users.filter { $0.id  == (Int(userText)! - 1) }).count == 1 {
                        selIndex = (users.indices.filter { users[$0].id == (Int(userText)! - 1) })[0]
                        tempUser.id = selIndex
                        contin = true
                    } else {
                        print("Invalid input.")
                    }
                } else {
                    print("Invalid input.")
                }
            }

            // new name for user
            print("Please enter a new name. Leave blank to keep as \(users[selIndex].name)")
            contin = false
            while contin == false {
                userText = readLine()!
                if userText == "" {
                    tempUser.name = users[selIndex].name
                    contin = true
                // checks if name is in the character limit
                } else if userText.count < 0 && userText.count > maxUserName {
                    print("Name must be between 0 & \(maxUserName + 1) characters.")
                } else {
                    tempUser.name = userText
                    contin = true
                }
            }
            
            // new email adress
            print("Please enter a new email. Leave blank to keep as \(users[selIndex].email)")
            contin = false
            while contin == false {
                userText = readLine()!
                if userText == "" {
                    tempUser.email = users[selIndex].email
                    contin = true
                } else if userText.count > 320 {
                    print("Email adress not possible.")
                } else {
                    tempUser.email = userText
                    contin = true
                }
            }

            // asks if user wants to confirm the changes
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
            print("\nAdd new user")
            // gets next userID
            tempUser.id = users.last!.id + 1
            contin = false
            // asks for name within bounds
            while contin == false {
                print("Name: ", terminator: "")
                userText = readLine()!
                if userText.count == 0 || userText.count > maxUserName {
                    print("Name must be between 0 & \(maxUserName + 1) characters.")
                } else {
                    tempUser.name = userText
                    contin = true
                }
            }

            // asks for email within bounds
            contin = false
            while contin == false {
                print("Email: ", terminator: "")
                userText = readLine()!
                // 320 as most sources say thats the max chars for email. no minimum incase user email is unknown
                if userText.count > 320 {
                    print("Email adress not possible.")
                } else {
                    tempUser.email = userText
                    contin = true
                }
            }

            print("\n\(tempUser.id+1). \(tempUser.name), \(tempUser.email)")
            print("Confirm add this user? Y/n")
            contin = false
            while contin == false {
                userText = readLine()!
                if userText.lowercased() == "y" || userText == "" {
                    users.append(tempUser)
                    print("User created.")
                    contin = true
                } else if userText.lowercased() == "n" {
                    print("Creation discarded.")
                    contin = true
                } else {
                    print("Please enter Y/n")
                }
            }

        }


        //MARK: Remove user
        func removeUser() {
            print("\nRemove user")
            userSummary(uID: -1)
            print("Please enter a users ID number. Enter a blank field to exit.")
            // generic user selection code
            contin = false
            while contin == false {
                userText = readLine()!
                if typeCheck(inputSTR: userText, type: "Int") == true {
                    if (users.filter { $0.id  == (Int(userText)! - 1) }).count == 1 {
                        selIndex = (users.indices.filter { users[$0].id == (Int(userText)! - 1) })[0]
                        contin = true
                    } else {
                        print("Invalid input.")
                    }
                } else if userText == "" {
                    return
                } else {
                    print("Invalid input.")
                }
            }

            // checks if user has current or previous loans. they must be removed first due to crashing issues
            if (loans.filter { $0.userID == users[selIndex].id }.count) != 0 {
                print("Cannot remove user with logged loans. Please return item(s) & prune logs before trying again.")
            } else {
                // not Y/n to prevent potential mistakes
                print("Would you like to delete \(users[selIndex].name)? y/n\nTHIS ACTION CAN NOT BE REVERSED")
                contin = false
                while contin == false {
                    userText = readLine()!
                    if userText.lowercased() == "y" {
                        users.remove(at: selIndex)
                        print("Deleted user.")
                        contin = true
                    } else if userText.lowercased() == "n" {
                        print("Operation cancelled")
                        contin = true
                    } else {
                        print("Please enter y/n")
                    }
                }
            }
        }


        // there are no double values here, but this was added when there was one. Hasnt been removed incase i need it again
        /// either "Int" or "Double". Checks if the provided string conforms to the spesified type
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

        /// Lists all instrument families
        func listFamilies() {
            for (index, item) in tempInst.instType.enumerated() {
                print("\(index + 1). \(item)")
            }
        }

        // Quits program
        func quit() {
            print("Exiting.")
            exit(0)
        }
    }
}
