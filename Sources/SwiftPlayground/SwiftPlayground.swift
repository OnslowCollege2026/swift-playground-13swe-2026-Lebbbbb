// The Swift Programming Language
// https://docs.swift.org/swift-book
// swift run
import Foundation

struct Student: Identifiable {
    let id: UUID = UUID()
    var name: String
    var age: Int
}

struct Course: CustomStringConvertible, Identifiable {
    let id: UUID = UUID()
    var title: String
    var courseDescription: String
    var description: String {
        "\(id). \(title) | \(courseDescription)"
    }
}

struct Enrolment: Codable {
    let studentId: UUID
    let courseID: UUID
}

struct ScoreEntry: Comparable {
    let studentID: UUID
    var points: Int
    static func < (lhs: ScoreEntry, rhs: ScoreEntry) -> Bool {
        lhs.points < rhs.points
    }
}

@main
struct SwiftPlayground {
    static func main() {
        let student1 = Student(name: "Millie", age: 43)
        let course1 = Course(
            title: "Millie is weird", courseDescription: "Teaches you all about Millies weirdness")
        let enrolled = Enrolment(studentId: student1.id, courseID: course1.id)
        let encoded = try! JSONEncoder().encode(enrolled)
        let decoded = try! JSONDecoder().decode(Enrolment.self, from: encoded)
        print (decoded)

        let students = [Student(name: "Leb", age: 16),
        Student(name: "Millie", age: 17),
        Student(name: "Phoebe", age: 17)]
        print ()

        let scoreEntery = [ScoreEntry(studentID: students[0].id, points: 3),
        ScoreEntry(studentID: students[1].id, points: 0),
        ScoreEntry(studentID: students[2].id, points: 40)]
        let scoresSorted = scoreEntery.sorted()
        for (index, student) in scoresSorted.enumerated() {
            print (students.first { student.studentID == students.id })
        }
    }
}
