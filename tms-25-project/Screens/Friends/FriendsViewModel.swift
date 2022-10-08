//
//  FriendsViewModel.swift
//  tms-25-project
//
//  Created by Daria Sechko on 4.09.22.
//

import UIKit

// Provider, ViewModel(MVVM) - класс-сервис, который поставляет данные

final class FriendsViewModel {
    
    var friendsAPI = FriendsAPI()
    var friendsArchiver = FriendsArchiverImpl()
    
    var friends: [Friend] = []
    var isFriendsLoading = false
    var friendsCount: Int = 0
    
    var friendsCanLoad: Bool {
        return friends.count < friendsCount
    }
    
    func fetchFriends(bindTo tableView: UITableView) {
        
        friendsAPI.fetchFriends(offset: 0) { friends, count in
            //  self.friends = friends
            
            self.friendsCount = count
            
            self.friendsArchiver.save(friends)
            let savedfriends = self.friendsArchiver.retrieve()
            
            self.friends = savedfriends
            
            tableView.reloadData()
        }
    }
    
    func fetchFriendsAsync(bindTo tableView: UITableView) {
        
        Task {
            do {
                let (friends, count) = try await friendsAPI.fetchFriendsAsync()

                self.friendsCount = count
                self.friends = friends
                
                await tableView.reloadData()
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func prefetchFriends(bindTo tableView: UITableView) {
        isFriendsLoading = true
        friendsAPI.fetchFriends(offset: friends.count) { friends, count in
            self.friends.append(contentsOf: friends)
            self.friendsCount = count
            tableView.reloadData()
            
            self.isFriendsLoading = false
        }
    }
}
