//
//  NetworkManager.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 2/7/21.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        config.allowsCellularAccess = true
        
        return session
    }()
    
    private init() {}
    
    func login(email: String, password: String) -> Bool {
        print("login: \(email); password: \(password)")
        
        return checkUserCredentials(email: email, password: password)
    }
    
    func getDataFromURL(url: String) {
        print("Getting data from: \(url)")
    }
    
    func checkUserCredentials(email: String, password: String) -> Bool {
        return email == "admin" && password == "123"
    }
    
    static func loadData(token: String, get: Getter) -> Void {
        let app = AppData()
        var getter = ""
        
        switch get {
            case .friends: getter = "friends"
            case .groups: getter = "groups"
            case .photos: getter = "photos"
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/\(getter).get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: app.version)
        ]
        
        guard let url = urlComponents.url else { return }
        
        let dataTask = NetworkManager.session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        dataTask.resume()
        
    }
}
