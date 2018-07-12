//
//  MapViewController.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/25/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import SwiftyJSON
class MapViewController: UIViewController, UISearchBarDelegate {
   
    @IBOutlet weak var mapView: MKMapView!
    
    var result = [CinemaNearby]()
     var geo:String?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
        if geo != nil{
        fetchNearCinema(location:"\(self.geo!)") { (cinemaList) in
            self.result = cinemaList
            print("hi",self.result)
        }
        }
    }
    
   
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
        //hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //create search request
        
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start{ (response,error) in
            if response == nil {
                print("ERROR")
            }else{
                //jump to next page
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                //gettting data
                let latitude = response?.boundingRegion.center.latitude
                let longtitude = response?.boundingRegion.center.longitude
                
                let lat:String = "\(String(describing: latitude!))"
                let long: String = "\(String(describing: longtitude!))"
                self.geo = lat + "," + long
                print("geo detect：",self.geo!)

                //create annotation
                print("create annotation")
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longtitude!)
                self.mapView.addAnnotation(annotation)
                
                //zooming in an annotation
                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longtitude!)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.mapView.setRegion(region, animated: true)
                
            }
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchNearCinema(location:String,completion:@escaping(_ cinemaList:[CinemaNearby]) -> ()){
        let url = "https://maps.googleapis.com/maps/api/place/radarsearch/json?location=\(location)&radius=20&type=movie_threater&key=AIzaSyBlVQXbDFLT0qjYnRlk8e6eRzJ8glgbCTg"
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
                            print(newCinema.lat)
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
