//
//  FriendsResponse.swift
//  tms-25-project
//
//  Created by Daria Sechko on 28.08.22.
//

import Foundation

// MARK: - FriendsResponse
struct FriendsResponse: Codable {
    let response: FriendsItems
}

// MARK: - Response
struct FriendsItems: Codable {
    let count: Int
    let items: [Friend]
}

// MARK: - Item
struct Friend: Codable {
    let id: Int
    let photo100: String
    let lastName: String
    let firstName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case firstName = "first_name"
    }
}
