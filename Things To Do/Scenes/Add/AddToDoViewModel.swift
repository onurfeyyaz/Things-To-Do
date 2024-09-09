//
//  AddToDoViewModel.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 4.07.2024.
//

import Foundation

protocol AddToDoViewModelProtocol {
    func addToDo(title: String, description: String, category: String, deadline: Date?, reminder: Date?, priority: ToDoPriority, status: ToDoStatus, tags: String)
}

final class AddToDoViewModel: ObservableObject {
    private let userDefaultsHelper: UserDefaultsHelper<ToDoItem>
    
    init(userDefaultsHelper: UserDefaultsHelper<ToDoItem> = UserDefaultsHelper<ToDoItem>(userDefaultsKey: Constants.toDoItemsKey)) {
        self.userDefaultsHelper = userDefaultsHelper
    }
}

extension AddToDoViewModel: AddToDoViewModelProtocol {
    func addToDo(title: String, description: String, category: String, deadline: Date?, reminder: Date?, priority: ToDoPriority, status: ToDoStatus, tags: String) {
        let newToDo = ToDoItem(
            title: title,
            description: description,
            category: category,
            deadline: deadline,
            reminder: reminder,
            priority: priority,
            status: status,
            tags: tags.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
        )
        
        userDefaultsHelper.addItem(newToDo)
    }
}
