//
//  UserService.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/27/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//
import Foundation
import Firebase

class UserService {
    
    static var currentUserProfile:User?
    
    static func observeUserProfile(_ uid:String, completion: @escaping ((_ userProfile:User?)->())) {
        let userRef = Database.database().reference().child("users/profile/\(uid)")
        
        userRef.observe(.value, with: { snapshot in
            var userProfile:User?
            
            if let dict = snapshot.value as? [String:Any],
                let username = dict["username"] as? String,
                let photoURL = dict["photoURL"] as? String,
                let url = URL(string:photoURL) {
                
                userProfile = User(uid: snapshot.key, username: username, photoURL: url)
            }
            
            completion(userProfile)
        })
    }
    
}
