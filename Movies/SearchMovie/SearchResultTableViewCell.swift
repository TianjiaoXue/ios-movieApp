//
//  FilmNowTableViewCell.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/24/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import UIKit

class FilmNowTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var filmNameLabel: UILabel!
    @IBOutlet weak var ageRatingLabel: UILabel!
    @IBOutlet weak var filmImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
