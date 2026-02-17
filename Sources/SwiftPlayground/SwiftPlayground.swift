// The Swift Programming Language
// https://docs.swift.org/swift-book
// swift run

@main
struct SwiftPlayground {
    static func main() {
        // Task 1
        print("Task 1")
        let mixed = ["cat", "7", "owl", "15", "dog", "3"]
        // Finds the Int from mixed list
        let mixedINT = mixed.compactMap { Int($0) }
        print(mixedINT)

        // Checks if any items in array arent Int (in string)
        let mixedChkStr = mixed.allSatisfy { Int($0) != nil }
        print(mixedChkStr)

        // Task 2
        print("\nTask 2")
        let sightings = [
            (name: "moth", score: 3),
            (name: "wolf", score: 9),
            (name: "raven", score: 4),
            (name: "mist", score: 7),
            (name: "wisp", score: 2),
        ]
        // Finds the total score of sightings name starting with w or m
        let sightingsFilterd =
            sightings
            .filter { ($0).name.first == "w" || ($0).name.first == "m" }
            .map { $0.score }
            .reduce(0) { $0 + $1 }
        print(sightingsFilterd)

        // Task 3
        print("\nTask 3")
        // Taking in a string and a second func, and runs that new func with the previous input
        func accepts(_ input: String, isValid: (String) -> Bool) -> Bool {
            return isValid(input)
        }

        let sample = "moonlight"
        // Calls accepts, with sample and declares isValid with its conditions
        print(accepts(sample, isValid: { $0 == $0.lowercased() && $0.count > 8 }))

        // Task 4
        print("\nTask 4")
        let archive = [
            [
                [["candle", "dust"], ["mirror", "ash"]],
                [["whisper", "shadow"], ["clock", "veil"]],
            ],
            [
                [["stone", "key"], ["relic", "name"]],
                [["cipher", "bone"], ["ember", "seal"]],
            ],
            [
                [["feather", "ink"], ["glow", "eclipse"]],
                [["riddle", "echo"], ["ember", "glyph"]],
            ],
        ]

        //let lastWing = archive.filter {  }
        //print (lastWing)
        //print (archive.flatMap { $0.flatMap { $0.flatMap { $0 } } })

        //let test = archive.enumerated().flatMap { "\($0) + \($1)" }
        //print (test)

        //print (archive.compactMap { $0.compactMap { $0.compactMap { $0.first } }})

        var archiveIndex: [Int] = []
        // Finds the last wing with word starting with "e"
        for (index, _) in archive.enumerated() {
            for (index1, _) in archive[index].enumerated() {
                for (index2, _) in archive[index][index1].enumerated() {
                    for (index3, _) in archive[index][index1][index2].enumerated() {
                        if ((archive[index][index1][index2][index3]).first) == "e" {
                            archiveIndex.append (index + 1)
                        }
                    }
                }
            }
        }

        // Finds last room with word with 4 char
        for (index, _) in archive[archiveIndex[0]].enumerated() {
            for (index1, _) in archive[archiveIndex[0]][index].enumerated() {
                for (index2, item) in archive[archiveIndex[0]][index][index1].enumerated() {
                    if item.count == 4 {
                        archiveIndex[1] = index2
                    }
                }
            }
        }
        for (index, _) in archive[archiveIndex[0]][archiveIndex[1]].enumerated() {
            for (index1, item) in archive[archiveIndex[0]][archiveIndex[1]][index].enumerated() {
                if item.first == "e" {
                    archiveIndex[2] = index1
                }
            }
        }

        for (index, item) in archive[archiveIndex[0]][archiveIndex[1]][archiveIndex[2]].enumerated() {
            if item.first == "e" {
                archiveIndex[3] = index
                //print (item)
            }
        }

        print (archive[archiveIndex[0]][archiveIndex[1]][archiveIndex[2]]/*[archiveIndex[3]]*/)
    }
}
