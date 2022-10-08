//
//  ViewController.swift
//  tms-25-project
//
//  Created by Daria Sechko on 25.08.22.
//

import UIKit
import WebKit

final class AuthVC: UIViewController {
    
    //MARK: - Properties
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        
        return webView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        if Session.isTokenValid {
            showMainTabBarScreen()
            return
        }
        authorizeVK()
        
    }
    
    //MARK: - Private
    private func setupViews() {
        view.addSubview(webView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        ])
    }
    
    private func loadUrl() {
        guard let url = URL.init(string: "https://teachmeskills.by") else { return }
        let request = URLRequest.init(url: url)
        webView.load(request)
    }
    
    private func authorizeVK() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem.init(name: "client_id", value: "8203478"),
            URLQueryItem.init(name: "display", value: "mobile"),
            URLQueryItem.init(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem.init(name: "scope", value: "friends,photos,audio,video,groups,wall"),
            URLQueryItem.init(name: "response_type", value: "token"),
            URLQueryItem.init(name: "revoke", value: "1"),
            URLQueryItem.init(name: "v", value: "5.131"),
        ]
        
        guard let url = urlComponents.url else { return }
        
        print(url)
        let request = URLRequest.init(url: url)
        webView.load(request)
    }
    
    
    //MARK: - Navigation
    
    private func showMainTabBarScreen() {
        
        let mainTabBarVC = MainTabBarVC()
        navigationController?.pushViewController(mainTabBarVC, animated: true)
        
    }
}
extension AuthVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            print("observe url -> ", navigationResponse.response.url ?? "")
            decisionHandler(.allow)
            return
        }
        
        let data = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
        
        print(data)
        
        let params =
        fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce(Dictionary<String, String>()) { partialResult, param in
                
                var dict = partialResult
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return  dict
            }
        
        print(params)
        
        guard let token = params["access_token"], let expiresIn = params["expires_in"], let userId = params["user_id"] else { return }
        
        Session.shared.token = token
        
        Session.shared.userId = Int.init(userId) ?? 0
        
        var tokenDate = Date.init(timeIntervalSinceNow: Double(expiresIn) ?? 0)
        
        Session.shared.expiresIn = tokenDate
        
        print("TOKEN -> ", token, Session.shared.expiresIn as Any)
        
        showMainTabBarScreen()
        
        decisionHandler(.cancel)
    }
}

