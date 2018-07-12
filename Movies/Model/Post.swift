//
//  Post.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/27/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import Foundation
class Post {
var id:String
var author:User
var text:String
var timestamp:Double

init(id:String, author:User,text:String,timestamp:Double) {
    self.id = id
    self.author = author
    self.text = text
    self.timestamp = timestamp
}
    func convertTimestamp(serverTimestamp: Double) -> String {
        let x = serverTimestamp / 1000
        let date = NSDate(timeIntervalSince1970: x)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter.string(from: date as Date)
    }
}
