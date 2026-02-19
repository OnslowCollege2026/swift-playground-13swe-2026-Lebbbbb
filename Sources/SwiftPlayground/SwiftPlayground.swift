// The Swift Programming Language
// https://docs.swift.org/swift-book
// swift run
struct Student {
    let id: String
    var name: String
    var age: Int
    let nsn: String
    var email: String

    func summary() -> String {
        return """
        ID: \(id)
        Name: \(name)
        Age: \(age)
        NSN: \(nsn)
        Email: \(email)
        """
    }
}

struct Car {
    let brand: String
    let model: String
    let year: String
}

struct BankAccount{
    var owner: String
    var balance: Double

    func description() -> String {
        return("\(owner)'s account has $\(balance) in it.")
    }
}

struct Rectangle {
    let width: Double
    let height: Double

    func area() -> Double {
        //return("Area: \(width * height)cm²")
        return(width*height)
    }
}


@main
struct SwiftPlayground {
    static func main() {
        // define students
        let students = [
            Student(id: "22810",name: "Leb",age: 16,nsn: "0144001856",email: "leb.foden@student.onslow.school.nz"),
            Student(id: "22811",name: "Millie",age: 17,nsn: "0144007383",email: "millie.armstrong@student.onslow.school.nz"),
            Student(id: "22812",name: "Phoebe",age: 17,nsn: "0144003333",email: "phoebe.thurnlow@student.onslow.school.nz"),
            Student(id: "22813",name: "Alex",age: 18,nsn: "0144001772",email: "alex.mccormic@student.onslow.school.nz"),
            Student(id: "22814",name: "June",age: 18,nsn: "0144002398",email: "june.ludlow@student.onslow.school.nz")
        ]
        // all student ages + 10 
        let studentsInADecace = students.map {"\($0.name) will be \($0.age + 10) years old in a decade."}
        for student in studentsInADecace {
            print(student)
        }

        // Task A
        print("\nTask A")
        let cars = [
            Car(brand: "BMW",model: "Super cool",year: "1836"),
            Car(brand: "Ford",model: "F151",year: "2027")
        ]
        print ("There are \(cars.count + 1) total cars in the garage")
        // Prints info about all cars in garage
        for (index, car) in cars.enumerated() {
            print ("\(index + 1). Is a \(car.brand) \(car.model) from \(car.year)")
        }

        // Task B
        print("\nTask B")
        let bankAccounts = [
            BankAccount(owner: "Leb Foden", balance: 60125.51),
            BankAccount(owner: "Millie Armstrong", balance: -23.0)
        ]
        for account in bankAccounts {
            print(account.description())
        }

        // Task C
        print("\nTask C")
        let rectangles = [
            Rectangle(width: 5, height: 2),
            Rectangle(width: 3.5, height: 6.5)
        ]
        var rectangleAreas: [Double] = []
        for (rect) in rectangles {
            //print(rect.area())
            rectangleAreas.append (rect.area())
        }
        print(rectangleAreas)
        rectangleAreas.sort(by: >)
        print(rectangleAreas)
    }
}
