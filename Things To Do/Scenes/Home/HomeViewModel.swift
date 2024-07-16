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
    
    @Published var toDoItems: [ToDoItem] = []
    
    private let userDefaultsHelper: UserDefaultsHelper<ToDoItem>
    
    init(userDefaultsHelper: UserDefaultsHelper<ToDoItem> = UserDefaultsHelper<ToDoItem>(userDefaultsKey: Constants.toDoItemsKey)) {
        self.userDefaultsHelper = userDefaultsHelper
        self.toDoItems = loadFromUserDefaults()
    }
    
    private func saveToUserDefaults() {
        userDefaultsHelper.saveData(toDoItems)
    }
    
    private func loadFromUserDefaults() -> [ToDoItem] {
        userDefaultsHelper.loadData()
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func addToDoItem(title: String) {
        let newItem = ToDoItem(title: title, isCompleted: false)
        toDoItems.append(newItem)
        saveToUserDefaults()
    }
}
