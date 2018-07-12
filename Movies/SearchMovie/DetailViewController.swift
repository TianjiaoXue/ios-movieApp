//
//  FilmNowDetailViewController.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/24/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {

    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filmNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    var movie : Movie?
    
    @IBAction func changeRate(_ sender: UISlider) {
        rateSlider.value = roundf(rateSlider.value)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        filmNameLabel.text = movie?.original_title
        releaseDateLabel.text = movie?.release_date
        ratingLabel.text = String(format:"%.1f", (movie?.vote_average)!)
        overViewLabel.text = movie?.overview
        let poster_path = movie?.poster_path
        let imageUrl = "https://image.tmdb.org/t/p/w500/"+poster_path!
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!)
        imageView.image = UIImage(data: data!)

        // let uid = Auth.auth().currentUser?.uid
        //print("Film Detail", uid,"is current login")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func rateMovie(_ sender: UIButton) {
        guard let userProfile = UserService.currentUserProfile else { return }
        let postRef = Database.database().reference().child("ratedMovie").childByAutoId()
        print(userProfile.username)
        let postObject = [
            "author": [
                "uid": userProfile.uid,
                "username": userProfile.username,
                "photoURL": userProfile.photoURL.absoluteString
            ],
            "movie": ["movie_id":movie?.id,"movie_name":movie?.original_title],
            "rate": rateSlider.value
            ] as [String:Any]
        
        postRef.setValue(postObject, withCompletionBlock: { error, ref in
            if error == nil {
                print("saving rated movie...")
                self.dismiss(animated: true, completion: nil)
            } else {
                print(error?.localizedDescription)
            }
        })
        let alert = UIAlertController(title: "Rated Movie", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveMovie(_ sender: UIButton) {
        guard let userProfile = UserService.currentUserProfile else { return }
        let postRef = Database.database().reference().child("savedMovie").childByAutoId()
        print(userProfile.username)
        let postObject = [
            "author": [
                "uid": userProfile.uid,
                "username": userProfile.username,
                "photoURL": userProfile.photoURL.absoluteString
            ],
            "movie": ["movie_id":movie!.id,"movie_name":movie!.original_title],
            ] as [String:Any]
        
        postRef.setValue(postObject, withCompletionBlock: { error, ref in
            if error == nil {
                print("saving movie for later review...")
                self.dismiss(animated: true, completion: nil)
            } else {
                print(error!.localizedDescription)
            }
        })
        let ac = UIAlertController(title: "Success", message: "Saved Movie for later!", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(OKAction)
        self.present(ac, animated: true, completion: nil)
            }
    
}
