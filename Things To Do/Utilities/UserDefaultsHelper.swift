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
    
    private let userDefaultStandart = UserDefaults.standard
    private let userDefaultsKey: String

    init(userDefaultsKey: String) {
        self.userDefaultsKey = userDefaultsKey
    }

    func saveToDoItems(_ items: [T]) {
        do {
            let encodedData = try JSONEncoder().encode(items)
            userDefaultStandart.set(encodedData, forKey: userDefaultsKey)
        } catch {
            #if DEBUG
                print("UserDefaults encoding error: \(error)")
            #else
                //TODO: show generic alert view
            #endif
        }
    }
    
    func loadToDoItems() -> [T] {
        if let savedData = userDefaultStandart.data(forKey: userDefaultsKey) {
            do {
                let decodedItems = try JSONDecoder().decode([T].self, from: savedData)
                return decodedItems
            } catch {
                #if DEBUG
                    print("UserDefaults decoding error: \(error)")
                #else
                    //TODO: show generic alert view
                #endif
            }
        }
        return []
    }
}
