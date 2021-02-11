//
//  Session.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 2/11/21.
//

import Foundation

class Session {
    static let shared = Session()
    
    var token = ""
    var userId = Int()
    
    private init() {}
}

enum Getter {
    case friends, groups, photos
}

