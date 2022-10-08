//
//  GroupsViewModel.swift
//  tms-25-project
//
//  Created by Daria Sechko on 4.09.22.
//

import UIKit

final class GroupsViewModel {
    
    var groupsAPI = GroupsAPI()
    var groups: [Group] = []
    var isGroupsLoading = false
    var groupsCount: Int = 0
    
    var groupsCanLoad: Bool {
        return groups.count < groupsCount
    }
    
    func fetchGroups(bindTo tableView: UITableView) {
        groupsAPI.fetchGroups(offset: 0) { groups, count in
            self.groups = groups
            self.groupsCount = count
            tableView.reloadData()
        }
    }
    
    func fetchGroupsAsync(bindTo tableView: UITableView) {
        Task {
            do {
                let groups = try await groupsAPI.fetchGroupsAsync()
                self.groups.append(contentsOf: groups)
                await tableView.reloadData()
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func prefetchGroups(bindTo tableView: UITableView) {
        isGroupsLoading = true
        groupsAPI.fetchGroups(offset: groups.count) { groups, count in
            self.groups.append(contentsOf: groups)
            self.groupsCount = count
            tableView.reloadData()
            
            self.isGroupsLoading = false
        }
    }
}
