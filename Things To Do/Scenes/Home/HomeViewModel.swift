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
    func removeData(at index: Int)
    func toggleCompletion(for item: ToDoItem)
    func groupedItems() -> [(String, [ToDoItem])]
    func sectionHeader(for key: String) -> String
}

enum GroupingCriteria {
    case status
    case category
}

final class HomeViewModel: ObservableObject {
    @Published var toDoItems: [ToDoItem] = []
    @Published var groupingCriteria: GroupingCriteria = .status
    
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
            userDefaultsHelper.updateItem(toDoItems[index])
        }
    }
    
    func addToDoItem(_ toDoItems: ToDoItem) {
        userDefaultsHelper.addItem(toDoItems)
        
    }
    
    func removeData(at index: Int) {
        userDefaultsHelper.removeData(toDoItems[index])
        toDoItems.remove(at: index)
    }
    
    func loadData() {
        toDoItems = userDefaultsHelper.loadData()
    }
    
    func groupedItems() -> [(String, [ToDoItem])] {
        switch groupingCriteria {
        case .status:
            return Dictionary(grouping: toDoItems, by: { $0.status.rawValue })
                .map { ($0.key.capitalized, $0.value) }
        case .category:
            return Dictionary(grouping: toDoItems, by: { $0.category })
                .map { ($0.key, $0.value) }
        }
    }
    
    func sectionHeader(for key: String) -> String {
        return key
    }
}
