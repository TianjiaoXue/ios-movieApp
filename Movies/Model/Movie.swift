//
//  Movie.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/24/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import Foundation
struct Movie {
    let id: Int
    let original_title : String
    let release_date: String
    let poster_path: String
    let overview: String
    let vote_count: Int
    let vote_average: Double
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    
    init(json:[String:Any])  throws{
        guard let id = json["id"] as? Int else {throw SerializationError.missing("id is missing")}
        guard let original_title = json["original_title"] as? String else {throw SerializationError.missing("title is missing")}
        guard let release_date = json["release_date"] as? String else {throw SerializationError.missing("release  date is missing")}
        guard let poster_path = json["poster_path"] as? String else {throw SerializationError.missing("poster is missing")}
        guard let overview = json["overview"] as? String else {throw SerializationError.missing("overview is missing")}
        guard let vote_count = json["vote_count"] as? Int else {throw SerializationError.missing("vote count is missing")}
        guard let vote_average = json["vote_average"] as? Double else {throw SerializationError.missing("vote average is missing")}
        
        self.id = id
        self.original_title = original_title
        self.release_date = release_date
        self.poster_path = poster_path
        self.overview = overview
        self.vote_count = vote_count
        self.vote_average = vote_average
    }
}
