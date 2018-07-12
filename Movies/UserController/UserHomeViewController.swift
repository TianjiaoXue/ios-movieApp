//
//  UserHomeViewController.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/23/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import UIKit
import Firebase
class UserHomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var ratedMovies = [RatedMovie]()
    var savedMovies = [SavedMovie]()
    //var result = ["ratedMoview","savedMovie","Posts"]

    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        profileImageView.clipsToBounds = true
        ImageService.getImage(withURL: (Auth.auth().currentUser?.photoURL)!) { image in
            self.profileImageView.image = image
        }
        tableView.delegate = self
        tableView.dataSource = self
//        getCurrentUser()
//        getRatedMovie()
        getSavedMovie()
        tableView.tableFooterView = UIView()
        //tableView.reloadData()
       
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//     return 2
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return ratedMovies.count
        return savedMovies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedMovie", for: indexPath) as! SavedMovieCell
        cell.nameLabel.text = savedMovies[indexPath.row].title
        return cell
       
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            let id = savedMovies[indexPath.row].id
                    deleteSavedMovie(id: id)
        }
        tableView.reloadData()
    
}
//        @IBAction func swiftTable(_ sender: UISegmentedControl) {
//            if sender.selectedSegmentIndex == 0{
//               getRatedMovie()
//            }else{
//               getSavedMovie()
//            }
//        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getCurrentUser(){
        guard let uid = Auth.auth().currentUser?.uid else{
            print("cannot find current user")
            return
        }
    }
        func getRatedMovie(){
            let movieRef = Database.database().reference().child("ratedMovie")
            //print(postsRef.description())
            movieRef.observe(.value, with: { snapshot in
                var tempMovie = [RatedMovie]()
                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                        let dict = childSnapshot.value as? [String:Any],
                        let author = dict["author"] as? [String:Any],
                        let uid = author["uid"] as? String,
                        let username = author["username"] as? String,
                        let photoURL = author["photoURL"] as? String,
                        let url = URL(string:photoURL),
                        let rate = dict["rate"] as? Int,
                    let movie = dict["movie"] as? [String:Any],
                        let movie_id = movie["movie_id"] as? Int,
                        let movie_title = movie["movie_name"] as? String{

                        if uid == Auth.auth().currentUser?.uid {
                            print("user match")
                        let userProfile = User(uid: uid, username: username, photoURL: url)
                        let ratedMovie = RatedMovie(id: childSnapshot.key, title: movie_title, movie_id: movie_id, rate: rate, user: userProfile)
                        tempMovie.append(ratedMovie)
                        }
                    }
                }
                self.ratedMovies = tempMovie
                self.tableView.reloadData()
            })
        }
    
    func getSavedMovie(){
        let movieRef = Database.database().reference().child("savedMovie")
        //print(postsRef.description())
        movieRef.observe(.value, with: { snapshot in
            var tempMovie = [SavedMovie]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let author = dict["author"] as? [String:Any],
                    let uid = author["uid"] as? String,
                    let username = author["username"] as? String,
                    let photoURL = author["photoURL"] as? String,
                    let url = URL(string:photoURL),
                    let movie = dict["movie"] as? [String:Any],
                    let movie_id = movie["movie_id"] as? Int,
                    let movie_title = movie["movie_name"] as? String{
                    
                    if uid == Auth.auth().currentUser?.uid {
                        print("user match")
                        let userProfile = User(uid: uid, username: username, photoURL: url)
                        let savedMovie = SavedMovie(id: childSnapshot.key, title: movie_title, movie_id: movie_id, user: userProfile)
                        tempMovie.append(savedMovie)
                    }
                }
            }
            self.savedMovies = tempMovie
            self.tableView.reloadData()
        })
    }
    
    func deleteSavedMovie(id: String) {
        let movieRef = Database.database().reference().child("savedMovie").child("\(id)")
        movieRef.removeValue()
        print("delete successfully...")
    }
    
    func deleteRatedMovie(id: String) {
        let movieRef = Database.database().reference().child("ratedMovie").child("\(id)")
        movieRef.removeValue()
        print("delete successfully...")
    }
    
    @IBAction func LogOut(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
    

}
  

