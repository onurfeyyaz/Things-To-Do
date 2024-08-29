//
//  HomeViewModel.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 25.06.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    func addToDoItem(_ toDoItems: ToDoItem)
    func loadData()
    func removeData(index: IndexSet)
    func toggleCompletion(for item: ToDoItem)
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
    func toggleCompletion(for item: ToDoItem) {
        if let index = toDoItems.firstIndex(where: { $0.id == item.id }) {
            toDoItems[index].isCompleted.toggle()
            addToDoItem(toDoItems[index])
        }
    }
    
    func addToDoItem(_ toDoItems: ToDoItem) {
        userDefaultsHelper.addItem(toDoItems)
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

extension HomeViewModel: AddToDoViewModelDelegate {
    func didLoadData() {
        
    }
}
