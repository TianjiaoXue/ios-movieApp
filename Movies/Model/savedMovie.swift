//
//  savedMovie.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/27/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import Foundation
struct SavedMovie {
    var id: String
    var title: String
    var movie_id: Int
    var user: User
    
    init(id:String, title:String, movie_id:Int, user:User) {
        self.id = id
        self.movie_id = movie_id
        self.title = title
        self.user = user
    }
}
