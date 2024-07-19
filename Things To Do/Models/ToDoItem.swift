//
//  TodoItem.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 25.06.2024.
//

import Foundation

enum ToDoStatus: Codable {
    case todo
    case doing
    case done
}

enum ToDoPriority: Codable {
    case low
    case medium
    case high
}

struct ToDoItem: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String
    var category: String
    var location: String?
    var isCompleted: Bool
    var creationDate: Date
    var deadline: Date?
    var reminder: Date?
    var status: ToDoStatus
    var priority: ToDoPriority
    var tags: [String]
    var attachments: [URL]
    var completionPercentage: Double {
        switch status {
        case .todo:
            0.0
        case .doing:
            50.0
        case .done:
            100.0
        }
    }
    
    init(title: String, 
         description: String,
         category: String = "",
         location: String? = nil,
         deadline: Date? = nil,
         reminder: Date? = nil,
         priority: ToDoPriority = .low,
         status: ToDoStatus = .todo,
         tags: [String] = [],
         attachments: [URL] = []) {
        
        self.id = UUID()
        self.title = title
        self.description = description
        self.category = category
        self.location = location
        self.isCompleted = false
        self.creationDate = Date()
        self.deadline = deadline
        self.reminder = reminder
        self.priority = priority
        self.status = status
        self.tags = tags
        self.attachments = attachments
    }
}
