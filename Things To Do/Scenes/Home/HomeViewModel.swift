//
//  HomeViewModel.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 25.06.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    func saveData(toDoItems: [ToDoItem])
    func loadData()
    func removeData(index: IndexSet)
    func isToDoCompleted(_ index: Int)
}

final class HomeViewModel: ObservableObject {
    
    @Published var toDoItems: [ToDoItem] = []
    
    private let userDefaultsHelper: UserDefaultsHelper<ToDoItem>
    
    init(userDefaultsHelper: UserDefaultsHelper<ToDoItem> = UserDefaultsHelper<ToDoItem>(userDefaultsKey: Constants.toDoItemsKey)) {
        self.userDefaultsHelper = userDefaultsHelper
        self.loadData()
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func isToDoCompleted(_ index: Int) {
        toDoItems[index].isCompleted.toggle()
        saveData(toDoItems: toDoItems)
    }
    
    func saveData(toDoItems: [ToDoItem]) {
        userDefaultsHelper.saveData(toDoItems)
    }
    
    func removeData(index: IndexSet) {
        for offset in index {
            userDefaultsHelper.removeData(toDoItems[offset])
            toDoItems.remove(at: offset)
        }
    }
    
    func loadData() {
        toDoItems = userDefaultsHelper.loadData()
    }
}
