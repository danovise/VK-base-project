//
//  GroupsVC.swift
//  tms-25-project
//
//  Created by Daria Sechko on 28.08.22.
//

import UIKit

final class GroupsVC: UIViewController {
    
    var viewModel = GroupsViewModel()
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.reuseID)
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
        
        setupView()
        setupConstraints()
        
        viewModel.fetchGroups(bindTo: tableView)
    }
    //MARK: - Request
    
    
    //MARK: - Private
    
    private func setupView() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.pinEdgesToSuperView()
    }
    
    //MARK: - Action
    
    @objc func pullToRefreshAction() {
        
        viewModel.fetchGroups(bindTo: tableView)
        refreshControl.endRefreshing()
        
    }
}
//MARK: - UITableViewDataSource

extension GroupsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseID, for: indexPath) as! GroupCell
        let group = viewModel.groups[indexPath.row]
        cell.configure(group)
        
        return cell
    }
}

//MARK: - UITableViewDataSourcePrefetching

extension GroupsVC: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let maxRow = indexPaths.map { $0.last ?? 0}.max() ?? 0
        print(maxRow)
        
        if maxRow > viewModel.groups.count - 5, viewModel.isGroupsLoading == false, viewModel.groupsCanLoad {
            print("prefetch request -> ")
            
            viewModel.prefetchGroups(bindTo: tableView)
            
        }
    }
}
