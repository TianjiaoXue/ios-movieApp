//
//  CinemaNearbyViewController.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/24/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class CinemaNearbyViewController: UIViewController {

    var geolocation = [String:String]()
    var result = [CinemaNearby]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNearCinema(location:"42.360082,-71.05888") { (cinemaList) in
            self.result = cinemaList
            //works here at least
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func fetchNearCinema(location:String,completion:@escaping(_ cinemaList:[CinemaNearby]) -> ()){
        let url = "https://maps.googleapis.com/maps/api/place/radarsearch/json?location=\(location)&radius=50&type=movie_threater&key=AIzaSyBlVQXbDFLT0qjYnRlk8e6eRzJ8glgbCTg"
        Alamofire.request(url)
            .responseJSON { (response) in
                if let json = response.result.value
                    {
                    let data = JSON(json)
                        let result = data["results"]
                    var cinemaList = [CinemaNearby]()
                        for _ in result{
                        if let lat = result[0]["geometry"]["location"]["lat"].double,
                            let lng = result[0]["geometry"]["location"]["lng"].double{
                            let newCinema = CinemaNearby(lat: lat,lng: lng)
                            cinemaList.append(newCinema)
                         }
                            completion(cinemaList)
                        }
                    }
        else {
                    print("error cause: ",response.result.error!)
                }
                
        }
    }
}
