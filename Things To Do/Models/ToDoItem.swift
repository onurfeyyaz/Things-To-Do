//
//  TodoItem.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 25.06.2024.
//

import Foundation

struct ToDoItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
}
