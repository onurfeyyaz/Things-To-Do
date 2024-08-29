//
//  AddToDoView.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 4.07.2024.
//

import SwiftUI

struct AddToDoView: View {
    @ObservedObject var viewModel: AddToDoViewModel
    @StateObject private var homeViewModel = HomeViewModel()
    @EnvironmentObject var router: Router
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var priority: ToDoPriority = .low
    @State private var status: ToDoStatus = .todo
    @State private var tags: String = ""
    @State private var category: String = ""
    @State private var hasDeadline = false
    @State private var deadline: Date? = nil
    @State private var hasReminder = false
    @State private var reminder: Date? = nil
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(Constants.AddToDoView.sectionHeaderTitle)) {
                    TextField(Constants.AddToDoView.title, text: $title)
                    TextField(Constants.AddToDoView.description, text: $description)
                }
                
                Section(header: Text(Constants.AddToDoView.sectionHeaderPriority)) {
                    Picker(Constants.AddToDoView.priority, selection: $priority) {
                        Text(Constants.AddToDoView.low).tag(ToDoPriority.low)
                        Text(Constants.AddToDoView.medium).tag(ToDoPriority.medium)
                        Text(Constants.AddToDoView.high).tag(ToDoPriority.high)
                    }
                    
                    Picker(Constants.AddToDoView.status, selection: $status) {
                        Text(Constants.AddToDoView.todo).tag(ToDoStatus.todo)
                        Text(Constants.AddToDoView.doing).tag(ToDoStatus.doing)
                        Text(Constants.AddToDoView.done).tag(ToDoStatus.done)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                
                Section(header: Text(Constants.AddToDoView.sectionHeaderAdditionalInfo)) {
                    TextField(Constants.AddToDoView.category, text: $category)
                    TextField(Constants.AddToDoView.tags, text: $tags)
                }
                
                Section(header: Text(Constants.AddToDoView.sectionHeaderDates)) {
                    Toggle(Constants.AddToDoView.hasDeadline, isOn: $hasDeadline)
                    if hasDeadline {
                        DatePicker(Constants.AddToDoView.pickerDeadline, selection: Binding(
                            get: { deadline ?? Date() },
                            set: { deadline = $0 }
                        ), displayedComponents: .date)
                    }
                    
                    Toggle(Constants.AddToDoView.hasReminder, isOn: $hasReminder)
                    if hasReminder {
                        DatePicker(Constants.AddToDoView.pickerReminder, selection: Binding(
                            get: { reminder ?? Date() },
                            set: { reminder = $0 }
                        ), displayedComponents: .date)
                    }
                }
                
                Button(action: {
                    if !title.isEmpty {
                        viewModel.addToDo(title: title,
                                          description: description,
                                          category: category,
                                          deadline: deadline,
                                          reminder: reminder,
                                          priority: priority,
                                          status: status,
                                          tags: tags)
                        router.openTab(.home)
                    }
                }) {
                    Text(Constants.AddToDoView.addToDoButton)
                        .frame(maxWidth: .infinity, minHeight: 18)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .navigationTitle("\(Date())")
        }
        .onAppear() {
            title = ""
            description = ""
            category = ""
            hasDeadline = false
            deadline = nil
            hasReminder = false
            reminder = nil
            priority = .low
            tags = ""
            status = .todo
            viewModel.delegate = homeViewModel
        }
    }
}

#Preview {
    AddToDoView(viewModel: AddToDoViewModel())
        .environmentObject(Router())
}
