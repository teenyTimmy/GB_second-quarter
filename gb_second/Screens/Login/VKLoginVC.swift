//
//  VKLoginVC.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 2/11/21.
//

import UIKit
import WebKit

class VKLoginVC: UIViewController {
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        let app = AppData()
        
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "display", value: app.display),
            URLQueryItem(name: "client_id", value: app.client_id),
            URLQueryItem(name: "scope", value: app.scope),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: app.version)
        ]
        
        guard let url = urlComponents.url else { return }
        
        webView.load(URLRequest(url: url))
    }
}

extension VKLoginVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, params in
                var dictionary = result
                let key = params[0]
                let value = params[1]
                
                dictionary[key] = value
    
                return dictionary
            }
        
        print("----------------------------")
        print("<<<<<<<<< PARAMS >>>>>>>>>>>")
        print("----------------------------")
        print(params)
        
        guard let token = params["access_token"],
              let userId = params["user_id"],
              let _ = Int(userId)
        else {
            decisionHandler(.allow)
            return
        }
        
        Session.shared.token = token
        print("<<<<<<< FRIENDS >>>>>>>>")
        NetworkManager.loadData(token: token, get: .friends)
        
        print("<<<<<<< GROUPS >>>>>>>>")
        NetworkManager.loadData(token: token, get: .groups)
        
        print("<<<<<<< PHOTOS >>>>>>>>")
        NetworkManager.loadData(token: token, get: .photos)
        
        decisionHandler(.cancel)
    }
}
