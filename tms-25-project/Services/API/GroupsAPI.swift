//
//  GroupsAPI.swift
//  tms-25-project
//
//  Created by Daria Sechko on 28.08.22.
//

import Foundation

final class GroupsAPI {
    
    func fetchGroupsAsync(offset: Int = 0) async throws -> [Group] {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        
        urlComponents.queryItems = [
            URLQueryItem.init(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem.init(name: "extended", value: "1"),
            URLQueryItem.init(name: "count", value: "8"),
            URLQueryItem.init(name: "offset", value: "\(offset)"),
            
            URLQueryItem.init(name: "v", value: "5.131"),
            URLQueryItem.init(name: "access_token", value: Session.shared.token),
        ]
        
        guard let url = urlComponents.url else { throw AppError.client }
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let groupsResponse = try? JSONDecoder().decode(GroupsResponse.self, from: data)
        let groups = groupsResponse?.response.items ?? []
        
        return groups
    }
    
    func fetchGroups(offset: Int = 0, completion: @escaping([Group], Int)->()) {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        
        urlComponents.queryItems = [
            URLQueryItem.init(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem.init(name: "extended", value: "1"),
            URLQueryItem.init(name: "count", value: "8"),
            URLQueryItem.init(name: "offset", value: "\(offset)"),
            
            URLQueryItem.init(name: "v", value: "5.131"),
            URLQueryItem.init(name: "access_token", value: Session.shared.token),
        ]
        
        guard let url = urlComponents.url else { return }
        
        var urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let jsonData = data else { return }
            let groupsResponse = try? JSONDecoder().decode(GroupsResponse.self, from: jsonData)
            let groups = groupsResponse?.response.items ?? []
            let groupsCount = groupsResponse?.response.count ?? 0
            
            DispatchQueue.main.async {
                print(Thread.current)
                completion(groups, groupsCount)
            }
            
        }.resume()
    }
}

