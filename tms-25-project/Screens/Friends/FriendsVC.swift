//
//  FriendsVC.swift
//  tms-25-project
//
//  Created by Daria Sechko on 25.08.22.
//

import UIKit

final class FriendsVC: UIViewController {
    
    var viewModel = FriendsViewModel()
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.reuseID)
        tableView.refreshControl = refreshControl
        
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
        return tableView
    }()
    
    lazy private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Идет обновление...")
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstrains()
        
        viewModel.fetchFriendsAsync(bindTo: tableView)
        
    }
    
    //MARK: - Private
    
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstrains() {
        tableView.pinEdgesToSuperView()
    }
    
    //MARK: - Action
    
    @objc func pullToRefreshAction() {
        
        viewModel.fetchFriendsAsync(bindTo: tableView)
        refreshControl.endRefreshing()
    }
}

//MARK: - UITableViewDataSource
extension FriendsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.reuseID, for: indexPath) as! FriendCell
        
        let friend = viewModel.friends[indexPath.row]
        cell.configure(friend)
        
        return cell
    }
}

//MARK: - UITableViewDataSourcePrefetching
extension FriendsVC: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        let maxRow = indexPaths.map { $0.last ?? 0}.max() ?? 0
        
        print(maxRow)
        
        if maxRow > viewModel.friends.count - 5, viewModel.isFriendsLoading == false, viewModel.friendsCanLoad {
            print("prefetch request -> ")
            
            viewModel.prefetchFriends(bindTo: tableView)
            
            //            viewModel.isFriendsLoading = true // Флажок - запрос в процессе
            //            viewModel.friendsAPI.fetchFriends(offset: viewModel.friends.count) { friends, _ in
            //                self.viewModel.friends.append(contentsOf: friends)
            //                self.tableView.reloadData()
            //                self.viewModel.isFriendsLoading = false
            //          }
        }
    }
}
