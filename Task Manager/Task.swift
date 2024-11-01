//
//  Untitled.swift
//  Task Manager
//
//  Created by usr on 2024/11/1.
//

import SwiftUI

struct Task: Identifiable {
    var id: UUID = .init()
    var title: String
    var caption: String
    var date: Date = .init()
    var isCompleted = false
    var tint: Color
}

// MARK: - Sample Task
var sampleTask: [Task] = [
    .init(title: "Standup", caption: "Every day meeting", date: Date.now, tint: .yellow),
    .init(title: "Kickoff", caption: "Travel App", date: Date.now, tint: .gray),
    .init(title: "Ui Design", caption: "Fintech App", date: Date.now, tint: .green),
    .init(title: "Logo Design", caption: "Fintech App", date: Date.now, tint: .purple),
]

// MARK: - Date Extension
extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
