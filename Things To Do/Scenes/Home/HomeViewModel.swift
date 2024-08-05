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
    // didSet?
    
    private let userDefaultsKey = "toDoItemsKey"
    
    init() {
        loadFromUserDefaults()
    }
    
    func addToDo(item: ToDoItem) {
        toDoItems.append(item)
    }
    
    private func saveToUserDefaults() {
        if let encodedData = try? JSONEncoder().encode(toDoItems) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        }
    }
    
    private func loadFromUserDefaults() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedItems = try? JSONDecoder().decode([ToDoItem].self, from: savedData) {
            toDoItems = decodedItems
        }
    }
}
