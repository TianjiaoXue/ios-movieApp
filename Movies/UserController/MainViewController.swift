//
//  ViewController.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/23/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import UIKit
import Firebase
class MainViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if Auth.auth().currentUser != nil {
//            self.performSegue(withIdentifier: "show", sender: self)
//        }
    }


}

