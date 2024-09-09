//
//  UserDefaultsHelper.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 2.07.2024.
//

import Foundation

protocol UserDefaultsHelperProtocol {
    associatedtype T: Codable & Identifiable & Equatable
    func loadData() -> [T]
    func removeData(_ item: T)
    func updateItem(_ item: T)
}

final class UserDefaultsHelper<T: Codable & Identifiable & Equatable>: UserDefaultsHelperProtocol {
    
    private let userDefaultStandart = UserDefaults.standard
    private let userDefaultsKey: String

    init(userDefaultsKey: String) {
        self.userDefaultsKey = userDefaultsKey
    }
    
    private func saveData(_ items: [T]) {
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
    
    func addItem(_ newItem: T) {
        var items = loadData()
        items.append(newItem)
        saveData(items)
    }
    
    func loadData() -> [T] {
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
    
    func updateItem(_ item: T) {
        var items = loadData()
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
            saveData(items)
        }
    }

    func removeData(_ item: T) {
        var items = loadData()
        items.removeAll(where: { $0.id == item.id })
        saveData(items)
    }
}
