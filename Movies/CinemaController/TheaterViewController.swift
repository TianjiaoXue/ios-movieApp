//
//  TheaterViewController.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/27/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GoogleMaps

class TheaterViewController: UIViewController {
    var latitude = [42.35904999999999,42.3531263,42.344686,42.3680642,42.3220987,42.21829229999999,42.36348770000001,42.3670121,42.3587791,42.247976]
    var longtitude = [-71.053511,-71.0639154,-71.101765,-71.0899234,-71.17063809999999,-71.03296159999999,-71.10126289999999,-71.06992629999999,-71.0501946,-71.17315499999999]
    var namelabel = ["Marriott Vacation Club Pulse at Custom House, Boston","AMC Loews Boston Common 19","Showcase SuperLux","AMC Braintree 10","Underground Railway Theater","Mugar Omni Theater","Simons IMAX Theater","Mugar Omni Theater","Simons IMAX Theater","Dedham Community Theatre"]
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocalTheater()
        let camera = GMSCameraPosition.camera(withLatitude: 42.361145, longitude: -71.057083, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.myLocationButton = true
        view = mapView
//        print(latitude)
//        print(longtitude)
        for i in 0...8 {
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude:latitude[i], longitude: longtitude[i])
        marker.title = namelabel[i]
       // marker.snippet = "US"
        marker.map = mapView
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLocalTheater(){
//        let headers = ["X-AMC-Vendor-Key":" F1CAEFE2-6E0C-45DB-8CB7-2CB4C7EF7484"]
//        let url = "https://api.amctheatres.com/v2/theatres/42"
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=42.2848,-71.0741&radius=10000&type=movie_theater&key=AIzaSyBlVQXbDFLT0qjYnRlk8e6eRzJ8glgbCTg"
        Alamofire.request(url, method:.get)
            .responseJSON{ (response) in
                //print(response)
                if let json = response.result.value as? [String: Any],
                    let threater = json["results"] as? [[String: Any]] {
                    for index in 0...9 {
                    let dict = JSON(json)
                    let lat = dict["results"][index]["geometry"]["location"]["lat"]
                    let lng = dict["results"][index]["geometry"]["location"]["lng"]
                    let name = dict["results"][index]["name"]
                       print(lat,lng, name)
                       
                    }

                    }
                else {
                    print("error cause: ",response.result.error!)
                }
        }
    }

}
