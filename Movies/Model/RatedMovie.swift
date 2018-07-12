
//
//  File.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/26/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import Foundation
struct RatedMovie {
    var id: String
    var title: String
    var movie_id: Int
    var rate: Int
    var user: User
    
    init(id:String, title:String, movie_id:Int, rate:Int, user:User) {
        self.id = id
        self.movie_id = movie_id
        self.title = title
        self.rate = rate
        self.user = user
    }
}
