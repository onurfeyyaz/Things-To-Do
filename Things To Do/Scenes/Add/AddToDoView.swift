//
//  AddToDoView.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 4.07.2024.
//

import SwiftUI

struct AddToDoView: View {
    @ObservedObject var viewModel: AddToDoViewModel = AddToDoViewModel()
    @EnvironmentObject var router: Router
    
    @State var toDoItem: ToDoItem = ToDoItem(title: "", description: "")
    @State var hasDeadline = false
    @State var hasReminder = false
    @State var tags: String = ""
    @State var deadline: Date = Date()
    @State var reminder: Date = Date()
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title and Description")) {
                    TextField("Title", text: $toDoItem.title)
                    TextField("Description", text: $toDoItem.description)
                }
                
                Section(header: Text("Priority and Status")) {
                    Picker("Priority", selection: $toDoItem.priority) {
                        Text("Low").tag(ToDoPriority.low)
                        Text("Medium").tag(ToDoPriority.medium)
                        Text("High").tag(ToDoPriority.high)
                    }
                    
                    Picker("Status", selection: $toDoItem.status) {
                        Text("To Do").tag(ToDoStatus.todo)
                        Text("Doing").tag(ToDoStatus.doing)
                        Text("Done").tag(ToDoStatus.done)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                
                Section(header: Text("Additional Info")) {
                    TextField("Category", text: $toDoItem.category)
                    TextField("Tags (comma separated)", text: $tags)
                }
                
                Section(header: Text("Dates")) {
                    Toggle("Has Deadline", isOn: $hasDeadline)
                    if hasDeadline {
                        DatePicker("Deadline", selection: $deadline, displayedComponents: .date)
                    }
                    
                    Toggle("Has Reminder", isOn: $hasReminder)
                    if hasReminder {
                        DatePicker("Reminder", selection: $reminder, displayedComponents: .date)
                    }
                }
                
                Button {
                    viewModel.addToDo(item: &toDoItem, tags: tags, deadline: deadline, reminder: reminder)
                    router.openTab(.home)
                } label: {
                    Text("Add To Do")
                }
            }
            .navigationTitle("\(Date())")
        }
        .onAppear() {
            toDoItem = ToDoItem(title: "", description: "")
            hasDeadline = false
            hasReminder = false
            tags = ""
            deadline = Date()
            reminder = Date()
        }
    }
}

#Preview {
    AddToDoView()
        .environmentObject(Router())
}
