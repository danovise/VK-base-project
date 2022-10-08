//
//  FriendsArchiver.swift
//  tms-25-project
//
//  Created by Daria Sechko on 16.09.22.
//

import Foundation

protocol FriendsArchiver {
    func save(_ Friends: [Friend])
    func retrieve() -> [Friend]
}

final class FriendsArchiverImpl: FriendsArchiver {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "Friends"
    
    //MARK: - Public methods
    func save(_ friends: [Friend]) {
        
        //Array<Student> -> Data
        do {
            let data = try encoder.encode(friends)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieve() -> [Friend] {
        
        //Data -> Array<Student>
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            let array = try decoder.decode(Array<Friend>.self, from: data)
            return array
        } catch {
            print(error)
        }
        return []
    }
}
