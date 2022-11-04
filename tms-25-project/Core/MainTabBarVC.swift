//
//  MainTabBarVC.swift
//  tms-25-project
//
//  Created by Daria Sechko on 27.08.22.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    var friendsVC: FriendsVC = {
        let friendsVC = FriendsVC()
        let friendsTabBarItem = UITabBarItem()
        friendsTabBarItem.image = UIImage(systemName: "person.2")
        friendsTabBarItem.title = "Друзья"
        friendsVC.tabBarItem = friendsTabBarItem
        
        return friendsVC
    }()
    
    var videosVC: VideosVC = {
        let videosVC = VideosVC()
        let videosTabBarItem = UITabBarItem()
        videosTabBarItem.image = UIImage(systemName: "video")
        videosTabBarItem.title = "Видео"
        
        videosVC.tabBarItem = videosTabBarItem
        return videosVC
    }()
    
    var groupsVC: GroupsVC = {
        let groupsVC = GroupsVC()
        let groupsTabBarItem = UITabBarItem()
        groupsTabBarItem.image = UIImage(systemName: "person.3")
        groupsTabBarItem.title = "Cообщества"
        
        groupsVC.tabBarItem = groupsTabBarItem
        return groupsVC
    }()
    
    var fakeVC: FakeVC = {
        let fakeVC = FakeVC()
        let fakeTabBarItem = UITabBarItem()
        fakeTabBarItem.image = UIImage(systemName: "person.2")
        fakeTabBarItem.title = "Fake"
        
        fakeVC.tabBarItem = fakeTabBarItem
        return fakeVC
    }()
    
    var newsFeedVC: NewsFeedVC = {
        let newsFeedVC = NewsFeedVC()
        let newsTabBarItem = UITabBarItem()
        newsTabBarItem.image = UIImage(systemName: "newspaper")
        newsTabBarItem.title = "News"
        
        newsFeedVC.tabBarItem = newsTabBarItem
        return newsFeedVC
    }()
    
    override func viewDidLoad() {
        let controllers: [UIViewController] = [friendsVC, groupsVC, newsFeedVC]
        self.viewControllers = controllers
        
        navigationItem.hidesBackButton = true
    }
}


