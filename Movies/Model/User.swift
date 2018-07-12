//
//  User.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/26/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import Foundation
struct User {
    
    var username: String
    var uid:String
    var photoURL:URL

    

    init(uid:String, username:String,photoURL:URL) {
        self.uid = uid
        self.username = username
        self.photoURL = photoURL
       
    }
}
