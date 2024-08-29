//
//  AddToDoViewModel.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 4.07.2024.
//

import Foundation

protocol AddToDoViewModelDelegate: AnyObject {
    func didLoadData()
}

protocol AddToDoViewModelProtocol {
    func addToDo(title: String, description: String, category: String, deadline: Date?, reminder: Date?, priority: ToDoPriority, status: ToDoStatus, tags: String)
}

final class AddToDoViewModel: ObservableObject, AddToDoViewModelProtocol {
    private let userDefaultsHelper: UserDefaultsHelper<ToDoItem>
    weak var delegate: AddToDoViewModelDelegate?
    
    init(userDefaultsHelper: UserDefaultsHelper<ToDoItem> = UserDefaultsHelper<ToDoItem>(userDefaultsKey: Constants.toDoItemsKey)) {
        self.userDefaultsHelper = userDefaultsHelper
    }
    
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
        delegate?.didLoadData()
    }
}
