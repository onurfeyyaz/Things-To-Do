//
//  HomeViewModel.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 25.06.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    func addToDo(item: ToDoItem)
}

final class HomeViewModel: ObservableObject {
    
    @Published var toDoItems: [ToDoItem] = []
    
    private let userDefaultsHelper: UserDefaultsHelper<ToDoItem>
    
    init(userDefaultsHelper: UserDefaultsHelper<ToDoItem> = UserDefaultsHelper<ToDoItem>(userDefaultsKey: Constants.toDoItemsKey)) {
        self.userDefaultsHelper = userDefaultsHelper
        self.toDoItems = userDefaultsHelper.loadData()

    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func addToDo(item: ToDoItem) {
        toDoItems.append(item)
        
        userDefaultsHelper.saveData(toDoItems)
    }
}
