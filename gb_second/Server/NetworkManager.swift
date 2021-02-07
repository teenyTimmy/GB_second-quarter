//
//  NetworkManager.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 2/7/21.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
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
}
