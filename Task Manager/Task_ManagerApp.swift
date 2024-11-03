//
//  Task_ManagerApp.swift
//  Task Manager
//
//  Created by usr on 2024/11/1.
//

import SwiftUI

@main
struct Task_ManagerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Task.self)
    }
}
