//
//  FriendsAPI.swift
//  tms-25-project
//
//  Created by Daria Sechko on 28.08.22.
//

import Foundation

enum NetworkError: Error {
        case badURL
        case decodingError
        case noData
}

final class FriendsAPI {
    
    func fetchFriendsAsync(offset: Int = 0) async throws -> ([Friend], Int) {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        
        urlComponents.queryItems = [
            URLQueryItem.init(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem.init(name: "order", value: "name"),
            URLQueryItem.init(name: "count", value: "20"),
            URLQueryItem.init(name: "offset", value: "\(offset)"),
            URLQueryItem.init(name: "fields", value: "photo_100,online"),
            
            URLQueryItem.init(name: "v", value: "5.131"),
            URLQueryItem.init(name: "access_token", value: Session.shared.token),
        ]
        
        guard let url = urlComponents.url else { throw NetworkError.badURL }
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let friendsResponse = try? JSONDecoder().decode(FriendsResponse.self, from: data)
        let friends = friendsResponse?.response.items ?? [ ]
        let friendsCount = friendsResponse?.response.count ?? 0
        return ( friends, friendsCount )
    }
    
    func fetchFriends(offset: Int = 0, completion: @escaping([Friend], Int)->()) {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        
        urlComponents.queryItems = [
            URLQueryItem.init(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem.init(name: "order", value: "name"),
            URLQueryItem.init(name: "count", value: "20"),
            URLQueryItem.init(name: "offset", value: "\(offset)"),
            URLQueryItem.init(name: "fields", value: "photo_100,online"),
            
            URLQueryItem.init(name: "v", value: "5.131"),
            URLQueryItem.init(name: "access_token", value: Session.shared.token),
        ]
        
        guard let url = urlComponents.url else { return }
        print(url)
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let jsonData = data else { return }
            let friendsResponse = try? JSONDecoder().decode(FriendsResponse.self, from: jsonData)
            let friends = friendsResponse?.response.items ?? []
            let friendsCount = friendsResponse?.response.count ?? 0
            
            DispatchQueue.main.async {
                print(Thread.current)
                completion(friends, friendsCount)
            }
            
        }.resume()
    }
}
