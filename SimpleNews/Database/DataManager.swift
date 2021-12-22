//
//  DataManager.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 12. 03..
//

import Foundation

final class DataManager {
    
    enum Constants {
        static let searchResponseKey = "searchResponseKey"
        static let savedNewsFavorites = "savedNewsFavorites"
        static let getNewsKey = "getNewsKey"
    }
    static let shared = DataManager()
    private init() {}
    
    func saveData <T: Codable>(data: T, forKey: String) {
        do {
            let data = try JSONEncoder().encode(data)
            UserDefaults.standard.setValue(data, forKey: forKey)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    func getSavedData<T: Codable>(type: T.Type, forKey: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: forKey) else {
            return nil
        }
        do {
            let results = try JSONDecoder().decode(T.self, from: data)
            return results
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
