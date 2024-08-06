//
//  AppConstants.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 4.07.2024.
//

import Foundation

struct Constants {
    
    static let appName = "Things To Do"
    static let toDoItemsKey = "toDoItemsKey"
    
    struct Tabbar {
        static let listView = "List"
        static let addView = "Add"
        static let profileView = "Profile"
    }
    
    struct HomeView {
        static let navigationTitleDoIt = "Do it!"
        static let navigationTitleDetailforIpad = "Select your thing to edit!"
        static let emptyViewMessage = "There is nothing to do here! \nYou can feel peaceful"
    }
    
    struct AddToDoView {
        static let sectionHeaderTitle = "Title and Description"
        static let sectionHeaderPriority = "Priority and Status"
        static let sectionHeaderAdditionalInfo = "Additional Info"
        static let sectionHeaderDates = "Dates"
        
        static let title = "Title"
        static let description = "Description"
        
        static let priority = "Priority"
        static let low = "Low"
        static let medium = "Medium"
        static let high = "High"
        
        static let status = "Status"
        static let todo = "To Do"
        static let doing = "Doing"
        static let done = "Done"
        
        static let category = "Category"
        static let tags = "Tags (comma separated)"
        
        static let hasDeadline = "Has Deadline"
        static let pickerDeadline = "Deadline"
        static let hasReminder = "Has Reminder"
        static let pickerReminder = "Reminder"
        
        static let addToDoButton = "Add To Do"
    }
}
