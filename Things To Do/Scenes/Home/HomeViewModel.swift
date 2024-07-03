//
//  HomeViewModel.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 25.06.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    func addToDoItem(title: String)
}

final class HomeViewModel: ObservableObject {
    
    @Published var toDoItems: [ToDoItem] = [] {
        didSet {
            saveToUserDefaults()
        }
    }
    
    private let userDefaultsHelper: UserDefaultsHelper<ToDoItem>
    
    init(userDefaultsHelper: UserDefaultsHelper<ToDoItem>) {
        self.userDefaultsHelper = userDefaultsHelper
        self.toDoItems = loadFromUserDefaults()
    }
    
    private func saveToUserDefaults() {
        userDefaultsHelper.saveToDoItems(toDoItems)
    }
    
    private func loadFromUserDefaults() -> [ToDoItem] {
        userDefaultsHelper.loadToDoItems()
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func addToDoItem(title: String) {
        let newItem = ToDoItem(title: title, isCompleted: false)
        toDoItems.append(newItem)
    }
}
