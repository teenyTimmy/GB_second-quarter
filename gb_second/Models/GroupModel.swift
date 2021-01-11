//
//  GroupModel.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 1/11/21.
//

import Foundation

struct GroupModel {
    var id: String
    var group: String
    var image: String
    var members: Int
    
    init(id: String, group: String, image: String, members: Int) {
        self.id = id
        self.group = group
        self.image = image
        self.members = members
    }
}
