//
//  UserDefaultsHelper.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 2.07.2024.
//

import Foundation

protocol UserDefaultsHelperProtocol {
    associatedtype T: Codable
    func saveToDoItems(_ items: [T])
    func loadToDoItems() -> [T]
}

final class UserDefaultsHelper<T: Codable>: UserDefaultsHelperProtocol {
    
    private let userDefaultsKey: String
    
    init(userDefaultsKey: String) {
        self.userDefaultsKey = userDefaultsKey
    }

    func saveToDoItems(_ items: [T]) {
        do {
            let encodedData = try JSONEncoder().encode(items)
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        } catch {
            // TODO: print usage when it's production?
            print("UserDefaults encoding error: \(error)")
        }
    }
    
    func loadToDoItems() -> [T] {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey) {
            do {
                let decodedItems = try JSONDecoder().decode([T].self, from: savedData)
                return decodedItems
            } catch {
                // TODO: print usage when it's production?
                print("UserDefaults decoding error: \(error)")
            }
        }
        return []
    }
}
