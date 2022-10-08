//
//  FakeVC.swift
//  tms-25-project
//
//  Created by Daria Sechko on 31.08.22.
//

import UIKit
import SwiftKeychainWrapper

class FakeVC: UIViewController {
    
    let fakeAPI = FakeAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        
        testUserDefaults()
        testKeyChain()
    }
    
    func testUserDefaults() {
        
        UserDefaults.standard.set("somestring", forKey: "token")
        let token = UserDefaults.standard.string(forKey: "token")
        
        print("testUserDefaults ->", token ?? "")
    }
    
    func testKeyChain() {
        
        KeychainWrapper.standard.set("stringKeyChain", forKey: "token")
        let token = KeychainWrapper.standard.string(forKey: "token")
        
        print("testKyChain ->", token ?? "")
    }
}


//        fakeAPI.createPost { post in
//            print("POST ->\n", post)
//        }
//
//        fakeAPI.patchPosts { post in
//            print("PATCH ->\n", post)
//        }
//
//        fakeAPI.deletePost { post in
//            print("DELETE ->\n", post)
//        }
//
//        fakeAPI.catchComments { comments in
//            print(comments)
//        }
//
//    }

