//
//  ContentView.swift
//  Task Manager
//
//  Created by usr on 2024/11/1.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentdate: Date = .init()
    
    // WeekSlider
    @State var weekSlider: [[Date.WeekDay]] = []
    @State var currentWeekIndex: Int = 1
    
    // Animation Namespace
    @Namespace private var animation
    
    @State private var createWeek: Bool = false
    
    // Now time to add Create Task Layout
    @State private var createNewTask: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading) {
                Text("Calendar")
                    .font(.system(size: 36, weight: .semibold))
                
                // Week Slider
                TabView(selection: $currentWeekIndex) {
                    ForEach(weekSlider.indices, id: \.self) { index in
                        let week = weekSlider[index]
                        
                        weekView(week)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 90)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background {
                Rectangle().fill(.gray.opacity(0.1))
                    .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
                    .ignoresSafeArea()
            }
            .onChange(of: currentWeekIndex, initial: false) { oldValue, newValue in
                if newValue == 0 || newValue == (weekSlider.count - 1) {
                    createWeek = true
                }
            }
            
            ScrollView(.vertical) {
                VStack {
                    TasksView(date: $currentdate)
                }
                .hSpacing(.center)
                .vSpacing(.center)
            }
            .scrollIndicators(.hidden)
        }
        .vSpacing(.top)
        .frame(maxWidth: .infinity)
        
        .onAppear {
            if weekSlider.isEmpty {
                let currentWeek = Date().fetchWeek()
                
                if let firstDate = currentWeek.first?.date {
                    weekSlider.append(firstDate.createPreviousWeek())
                }
                
                weekSlider.append(currentWeek)
                
                if let lastDate = currentWeek.last?.date {
                    weekSlider.append(lastDate.createNextWeek())
                }
            }
        }
        // Add New Task Button
        .overlay(alignment: .bottomTrailing) {
            Button(action: {
                createNewTask.toggle()
            }, label: {
                Image(systemName: "plus")
                    .imageScale(.large)
                    .padding(26)
                    .foregroundColor(.white)
                    .background(.black)
                    .clipShape(Circle())
                    .padding([.horizontal])
            })
            .fullScreenCover(isPresented: $createNewTask, content: {
                NewTask()
            })
        }
    }
    
    // MARK: - Week View
    @ViewBuilder
    func weekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0) {
            ForEach(week) { day in
                VStack {
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundColor(.gray)
                    
                    Text(day.date.format("dd"))
                        .font(.system(size: 20))
                        .frame(width: 50, height: 55)
                        .foregroundStyle(isSameDate(day.date, currentdate) ? .white : .black)
                        .background {
                            if isSameDate(day.date, currentdate) {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.black)
                                    .offset(y: 3)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                            }
                            
                            // 白色圓點
                            if day.date.isToday {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 5, height: 5)
                                    .vSpacing(.bottom)
                            }
                        }
                }
                .hSpacing(.center)
                .onTapGesture {
                    withAnimation(.snappy) {
                        currentdate = day.date
                    }
                }
            }
        }
        .background {
            GeometryReader {
                let minX = $0.frame(in: .global).minX
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self) { value in
                        if value.rounded() == 15 && createWeek {
                            paginateWeek()
                            createWeek = false
                        }
                    }
            }
        }
    }
    
    func paginateWeek() {
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1) {
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
            }
        }
    }
}

#Preview {
    ContentView()
}
