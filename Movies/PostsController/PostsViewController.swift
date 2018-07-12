//
//  PostsViewController.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/27/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import UIKit
import Firebase
class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var posts = [Post]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //just incase using iphoneX
        var layoutGuide: UILayoutGuide!
        if #available(iOS 11.0, *) {
            layoutGuide = view.safeAreaLayoutGuide
        }else{
            layoutGuide = view.layoutMarginsGuide
        }
        tableView.delegate = self
        tableView.dataSource = self
        observePosts()
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        
    }
    func observePosts() {
        let postsRef = Database.database().reference().child("posts")
        print(postsRef.description())
        postsRef.observe(.value, with: { snapshot in
            var tempPosts = [Post]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let author = dict["author"] as? [String:Any],
                    let uid = author["uid"] as? String,
                    let username = author["username"] as? String,
                    let photoURL = author["photoURL"] as? String,
                    let url = URL(string:photoURL),
                    let text = dict["text"] as? String,
                    let timestamp = dict["timestamp"] as? Double {
                    let userProfile = User(uid: uid, username: username, photoURL: url)
                    let post = Post(id: childSnapshot.key, author: userProfile, text: text, timestamp:timestamp)
                    tempPosts.append(post)
                }
            }
            self.posts = tempPosts
            self.tableView.reloadData()
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostsTableViewCell
        cell.set(post: posts[indexPath.row])
        return cell
    }
    
    
    
}
