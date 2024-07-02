//
//  UserDefaultsHelper.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 2.07.2024.
//

import Foundation

final class UserDefaultsHelper {
    
    private let toDoItemsKey = "toDoItemsKey"

    func saveToDoItems(_ items: [ToDoItem]) {
        do {
            let encodedData = try JSONEncoder().encode(items)
            UserDefaults.standard.set(encodedData, forKey: toDoItemsKey)
        } catch {
            print("UserDefaults encoding error: \(error)")
        }
    }
    
    func loadToDoItems() -> [ToDoItem] {
        if let savedData = UserDefaults.standard.data(forKey: toDoItemsKey) {
            do {
                let decodedItems = try JSONDecoder().decode([ToDoItem].self, from: savedData)
                return decodedItems
            } catch {
                print("UserDefaults decoding error: \(error)")
            }
        }
        return []
    }
}
