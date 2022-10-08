//
//  NewsFeedVC.swift
//  tms-25-project
//
//  Created by Daria Sechko on 18.09.22.
//

import UIKit

enum PostCellType: Int, CaseIterable {
    case author
    case text
    case photo
    case likes
}


final class NewsFeedVC: UIViewController {
    
    var posts: [PostModelCell] = []
    var newsFeedAPI = NewsFeedAPI()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(PostAuthorCell.self, forCellReuseIdentifier: PostAuthorCell.reuseId)
        tableView.register(PostTextCell.self, forCellReuseIdentifier: PostTextCell.reuseId)
        tableView.register(PostPhotoCell.self, forCellReuseIdentifier: PostPhotoCell.reuseId)
        tableView.register(PostLikesCell.self, forCellReuseIdentifier: PostLikesCell.reuseId)
        
        return tableView
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchPost()
    }
    
    //MARK: - Request
    private func fetchPost() {
        
        newsFeedAPI.fetchPosts(offset: 0) { [weak self] posts in
            
            guard let self = self else {return}
            
            self.posts = posts
            
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Private
    private func setupViews(){
        view.addSubview(tableView)
        tableView.pinEdgesToSuperView()
    }
}

extension NewsFeedVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = posts[indexPath.section]
        
        if let cellType = PostCellType.init(rawValue: indexPath.row) {
            switch cellType {
            case .text:
                return post.text.isEmpty ? 0 : UITableView.automaticDimension
            case .photo:
                return post.photoUrl.isEmpty ? 0 : UIScreen.main.bounds.width * post.aspectRatio
            default: return UITableView.automaticDimension
            }
        }
        return UITableView.automaticDimension
    }
    
}

extension NewsFeedVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostCellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.section]
        
        if let cellType = PostCellType.init(rawValue: indexPath.row) {
            
            switch cellType {
            case .author:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PostAuthorCell.reuseId, for: indexPath) as? PostAuthorCell else { return UITableViewCell() }
                cell.configure(post)
                return cell
                
            case .text:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTextCell.reuseId, for: indexPath) as? PostTextCell else { return UITableViewCell() }
                
                cell.configure(post)
                return cell
                
            case .photo:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PostPhotoCell.reuseId, for: indexPath) as? PostPhotoCell else { return UITableViewCell() }
                
                cell.configure(post)
                return cell
                
            case .likes:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PostLikesCell.reuseId, for: indexPath) as? PostLikesCell else { return UITableViewCell() }
                cell.configure(post)
                return cell
            }
        }
        return UITableViewCell()
    }
}
