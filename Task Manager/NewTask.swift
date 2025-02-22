//
//  NewTask.swift
//  Task Manager
//
//  Created by usr on 2024/11/2.
//

import SwiftUI
import SwiftData

struct NewTask: View {
    @Environment(\.dismiss) var dismiss
    @State private var taskTitle: String = ""
    @State private var taskCaption: String = ""
    @State private var taskDate: Date = .init()
    @State private var taskColor: String = "taskColor 1"
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Label("Add new Task", systemImage: "arrow.left")
                    .onTapGesture {
                        dismiss()
                    }
                
                VStack(spacing: 20) {
                    TextField("Your Task Title", text: $taskTitle)
                }
                .padding(.top)
            }
            .hSpacing(.leading)
            .padding(30)
            .frame(maxWidth: .infinity)
            .background {
                Rectangle().fill(.gray.opacity(0.1))
                    .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
                    .ignoresSafeArea()
            }
            
            // Task Title
            
            VStack(alignment: .leading, spacing: 30) {
                VStack(spacing: 20) {
                    TextField("Your Task Caption", text: $taskCaption)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Timeline")
                        .font(.title3)
                    
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.compact)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Task Color")
                        .font(.title3)
                    
                    let colors: [String] = (1...7).compactMap { index -> String in
                        return "taskColor \(index)"
                    }
                    HStack(spacing: 10) {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .fill(Color(color).opacity(0.4))
                                .hSpacing(.center)
                                .background {
                                    Circle().stroke(lineWidth: 2)
                                        .opacity(taskColor == color ? 1 : 0)
                                }
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        taskColor = color
                                    }
                                }
                        }
                    }
                }
            }
            .padding(30)
            .vSpacing(.top)
            
            Button {
                // 儲存任務
                let task = Task(title: taskTitle, caption: taskCaption, date: taskDate, tint: taskColor)
                do {
                    context.insert(task)
                    try context.save()

                    // try context.delete(model: Task.self)
                    
                    dismiss()
                } catch {
                    print(error.localizedDescription)
                }
            } label: {
                Text("Create Task")
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .foregroundColor(.white)
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding(.horizontal, 30)
            }
        }
        .vSpacing(.top)
    }
}

#Preview {
    NewTask()
}
