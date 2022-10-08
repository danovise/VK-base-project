//
//  FakeAPI.swift
//  tms-25-project
//
//  Created by Daria Sechko on 31.08.22.
//

import Foundation

// MARK: - PostElement
struct Post1: Codable {
    let userID, id: Int
    let title, body: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

enum AppError: Error {
    case client
    case server
    case noNetwork
    
    var description: String {
        switch self {
            
        case .client:
            return "Client error"
        case .server:
            return "Server error"
        case .noNetwork:
            return "No network"
        }
    }
}

class FakeAPI {
    
    func createPost(completion: @escaping(Post1)->()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme  = "https"
        urlComponents.host = "jsonplaceholder.typicode.com"
        urlComponents.path = "/posts"
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
        
        do {
            let bodyParams: [String: Any] = ["title": "foo", "body": "bar", "userId": 1]
            let bodyData = try JSONSerialization.data(withJSONObject: bodyParams, options: .prettyPrinted)
            request.httpBody = bodyData
            
        } catch {
            print(error)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let jsonData = data else { return }
            
            do {
                let post = try JSONDecoder().decode(Post1.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(post)
                }
            }
            catch {
                print(error)
            }
            
        }.resume()
    }
    
    func patchPosts(completion: @escaping(Post1)->()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme  = "https"
        urlComponents.host = "jsonplaceholder.typicode.com"
        urlComponents.path = "/posts/1"
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest.init(url: url)
        request.httpMethod = "PATCH"
        
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
        
        do {
            let bodyParams: [String: String] = ["title": "foo"]
            let bodyData = try JSONSerialization.data(withJSONObject: bodyParams, options: .prettyPrinted)
            request.httpBody = bodyData
            
        } catch {
            print(error)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let jsonData = data else { return }
            
            do {
                let post = try JSONDecoder().decode(Post1.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(post)
                }
            }
            catch {
                print(error)
            }
            
        }.resume()
    }
    
    func deletePost(completion: @escaping(Post1)->()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme  = "https"
        urlComponents.host = "jsonplaceholder.typicode.com"
        urlComponents.path = "/posts/1"
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest.init(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let jsonData = data else { return }
            
            do {
                let post = try JSONDecoder().decode(Post1.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(post)
                }
            }
            catch {
                print(error)
            }
            
        }.resume()
    }
    
    func catchComments(completion: @escaping(Post1)->()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme  = "https"
        urlComponents.host = "jsonplaceholder.typicode.com"
        urlComponents.path = "/posts/1/comments"
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let jsonData = data else { return }
            
            do {
                let comments = try JSONDecoder().decode(Post1.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(comments)
                }
            }
            catch {
                print(error)
            }
            
        }.resume()
    }
}
