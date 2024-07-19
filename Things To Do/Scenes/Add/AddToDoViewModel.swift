//
//  AddToDoViewModel.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 4.07.2024.
//

import Foundation

protocol AddToDoViewModelProtocol {
    func addToDo( item: inout ToDoItem, tags: String, deadline: Date, reminder: Date)
}

final class AddToDoViewModel: ObservableObject {
    var toDoItems: [ToDoItem] = []
    
}

extension AddToDoViewModel: AddToDoViewModelProtocol {
    func addToDo(item: inout ToDoItem, tags: String, deadline: Date, reminder: Date) {
        item.tags = tags.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
        item.deadline = deadline
        item.reminder = reminder
        
        toDoItems.append(item)
    }
}
