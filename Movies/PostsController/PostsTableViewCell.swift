//
//  PostTableViewCell.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/27/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var postTextLabel: UILabel!
    
    @IBOutlet weak var profileView: UIImageView!
    
    func set(post:Post) {
        ImageService.getImage(withURL: post.author.photoURL) { image in
            self.profileView.image = image
        }
        usernameLabel.text = post.author.username
        let date:String = post.convertTimestamp(serverTimestamp: post.timestamp)
        subtitleLabel.text = date
        postTextLabel.text = post.text
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileView.layer.cornerRadius = profileView.bounds.height / 2
        profileView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
