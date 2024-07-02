//
//  HomeViewModel.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 25.06.2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var toDoItems: [ToDoItem] = [] {
        didSet {
            saveToUserDefaults()
        }
    }
     
    private let userDefaultsHelper = UserDefaultsHelper()
    
    init() {
        loadFromUserDefaults()
    }
    
    func addToDoItem(title: String) {
        let newItem = ToDoItem(title: title, isCompleted: false)
        toDoItems.append(newItem)
    }
    
    private func saveToUserDefaults() {
        userDefaultsHelper.saveToDoItems(toDoItems)
    }
    
    private func loadFromUserDefaults() {
        toDoItems = userDefaultsHelper.loadToDoItems()
    }
}
