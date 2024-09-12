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
            if toDoItems[index].isCompleted {
                toDoItems[index].status = .done
            } else {
                toDoItems[index].status = .todo
            }
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
        let grouped: [String: [ToDoItem]]
        
        switch groupingCriteria {
        case .status:
            grouped = Dictionary(grouping: toDoItems, by: { $0.status.rawValue })
        case .category:
            grouped = Dictionary(grouping: toDoItems, by: { $0.category })
        }
        
        let sortedGrouped = grouped.sorted { $0.key < $1.key }
        return sortedGrouped.map { ($0.key.capitalized, $0.value) }
    }
    
    func sectionHeader(for key: String) -> String {
        return key
    }
}
