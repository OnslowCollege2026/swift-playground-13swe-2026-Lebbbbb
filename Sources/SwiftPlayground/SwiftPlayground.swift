// The Swift Programming Language
// https://docs.swift.org/swift-book
// swift run
import Foundation
import GRDB

/// hello everyoneaaaaa
struct Purchaser: Identifiable, Codable, FetchableRecord, PersistableRecord {
    let id: Int
    var name: String
    var count: Int
    var reservedTable: Int

    enum CodingKeys: String, CodingKey {
        case id = "PurchaserID"
        case name = "Name"
        case count = "Count"
        case reservedTable = "ReservedTable"
    }

    enum Columns {
        static let id = Column("PurchaserID")
        static let name = Column("Name")
        static let count = Column("Count")
        static let reservedTable = Column("ReservedTable")
    }
}

struct Item: Identifiable, Codable, FetchableRecord, PersistableRecord, CustomStringConvertible {
    let id: Int
    let name: String
    let price: Double

    var description: String {
        "\(id). \(name) - $\(price)"
    }

    enum CodingKeys: String, CodingKey {
        case id = "ItemID"
        case name = "Name"
        case price = "Price"
    }
}

struct Order: Identifiable, Codable, FetchableRecord, PersistableRecord {
    let id: Int
    let purchaserID: Int
    let amount: Double

    enum CodingKeys: String, CodingKey {
        case id = "OrderID"
        case purchaserID = "PurchaserID"
        case amount = "Amount"
    }
}

struct OrderLine: Codable, FetchableRecord, PersistableRecord {
    let orderID: Int
    var itemID: Int
    var quantity: Int

    enum Columns {
        static let orderID = Column("OrderID")
        static let itemID = Column("ItemID")
        static let quantity = Column("Quantity")
    }
}


@main
struct SwiftPlayground {
    static func main() {
        let dbPath = "./Sources/SwiftPlayground/cafe.db"
        guard let dbQueue = try? DatabaseQueue(path: dbPath) else {
            fatalError("Could not open database.")
        }

        var purchaser: Purchaser? = nil
        var orderLines: OrderLine? = nil

        do {
            try dbQueue.read { db in
                //try db.dumpSchema()

                // Fetches two purchasers, handles if nil
                for i in 2...3 {
                    purchaser = try Purchaser.fetchOne(db, key: i)
                    if purchaser == nil {
                        print("Error: Purchaser not found")
                    } else {
                        print(purchaser!)
                    }
                }
                // Prints the details of one item
                let item = try Item.fetchOne(db, key: 1)
                print(item!)
            }
        } catch {
            print(error)
        }

        do {
            try dbQueue.read { db in
                let order = try Order.fetchOne(db, key: 0)
                // finds the purchaser linked to the order
                let foundPurchaser = try Purchaser
                    .filter(Purchaser.Columns.id == order!.purchaserID)
                    .fetchOne(db)
                print(foundPurchaser!)
                
                orderLines = try OrderLine
                    .filter(OrderLine.Columns.orderID == order!.id)
                    .fetchAll(db)
                orderLines[1].itemID = 2
                print(orderLines)
            }
        } catch {
            print(error)
        }

        do {
            try dbQueue.write { db in

                try orderLines[1].update(db)
            }
        } catch {
            print(error)
        }



    }
}
