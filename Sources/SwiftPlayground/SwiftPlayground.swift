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
        var lastWingE: [Int] = []
        for (index, _) in archive.enumerated() {
            //print ("\(item) \(index)")
            for (index1, _) in archive[index].enumerated() {
                //print ("\(item) \(index1)")
                for (index2, _) in archive[index][index1].enumerated() {
                    //print ("\(item) \(index2)")
                    for (index3, _) in archive[index][index1][index2].enumerated() {
                        //print (archive[index][index1][index2][index3].last )
                        //let  archive[index][index1][index2][index3].first == "e"
                        if ((archive[index][index1][index2][index3]).first) == "e" {
                            lastWingE = [index, index1, index2, index3]
                        }
                    }
                }
            }
        }
        print (archive[lastWingE[0]][lastWingE[1]][lastWingE[2]][lastWingE[3]])
    }
}
