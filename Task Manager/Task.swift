//
//  Untitled.swift
//  Task Manager
//
//  Created by usr on 2024/11/1.
//

import SwiftUI
import SwiftData

@Model
class Task: Identifiable {
    var id: UUID
    var title: String
    var caption: String
    var date: Date
    var isCompleted: Bool
    var tint: String
    
    init(id: UUID = .init(), title: String, caption: String, date: Date = .init(), isCompleted: Bool = false, tint: String) {
        self.id = id
        self.title = title
        self.caption = caption
        self.date = date
        self.isCompleted = isCompleted
        self.tint = tint
    }
    
    var tintColor: Color {
        switch tint {
            case "taskColor 1": .taskColor1
            case "taskColor 2": .taskColor2
            case "taskColor 3": .taskColor3
            case "taskColor 4": .taskColor4
            case "taskColor 5": .taskColor5
            case "taskColor 6": .taskColor6
            case "taskColor 7": .taskColor7
            default: .black
        }
    }
}

// MARK: - Sample Task
/*var sampleTask: [Task] = [
    .init(title: "Standup", caption: "Every day meeting", date: Date.now, tint: .yellow),
    .init(title: "Kickoff", caption: "Travel App", date: Date.now, tint: .gray),
    .init(title: "Ui Design", caption: "Fintech App", date: Date.now, tint: .green),
    .init(title: "Logo Design", caption: "Fintech App", date: Date.now, tint: .purple),
]*/

// MARK: - Date Extension
extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
