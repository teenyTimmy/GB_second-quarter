//
//  User.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 1/11/21.
//

import Foundation

struct UserModel {
    var id: String
    var name: String
    var surname: String
    var image: String
    
    init(id: String, name: String, surname: String, image: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.image = image
    }
}
