//
//  PopularMovieViewController.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/25/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit
import CollectionKit

class PopularMovieViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    @IBOutlet weak var categoryCollection: UICollectionView!
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    var result =  [Movie]()
    var category = ["Top Rate","Now Online","Coming"]
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchTopMovies() { (movieList) in
//            self.result = movieList
//        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.movieCollectionView{
            return result.count
        }
        else{
            return category.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.movieCollectionView{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! PopularMovieCollectionViewCell
        let movie = result[indexPath.row]
        let poster_path = movie.poster_path
        let imageUrl = "https://image.tmdb.org/t/p/w500/"+poster_path
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!)
        cell.imageView?.image = UIImage(data:data!)
        cell.nameLabel.text = movie.original_title
        return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            let name = category[indexPath.row]
            cell.categoryLabel.text = name
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.movieCollectionView{
        let des:DetailViewController = self.storyboard!.instantiateViewController(withIdentifier: "detail") as! DetailViewController
        des.movie = result[indexPath.row]
        present(des, animated: true, completion: nil)
        }
        else{
            let c = indexPath.row
            if c == 0 {
               // print("select 0")
                fetchTopMovies() { (movieList) in
                    self.result = movieList
                    self.movieCollectionView.reloadData()
                   // print("result:",self.result.count)
                }
            }
            else if c == 1{
               // print("select 1")
                fetchRecentMovies() { (movieList) in
                    self.result = movieList
                    self.movieCollectionView.reloadData()
                    // print("result:",self.result.count)
                }
            }
            else{
               // print("select 2")
                fetchUpcomingMovies() { (movieList) in
                    self.result = movieList
                    self.movieCollectionView.reloadData()
                     //print("result:",self.result.count)
                }
            }
          }
    }
    

    func fetchTopMovies(completion:@escaping(_ movieList:[Movie]) -> ()){
        let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=7984d2ca0e6fe87cb9bc7eb403df05eb&language=en-US&page=5"
        Alamofire.request(url)
            .responseJSON{ (response) in
                if let json = response.result.value as? [String: Any],
                    let movies = json["results"] as? [[String: Any]] {
                    
                    var movieList = [Movie]()
                    for movie in movies{
                        if let newmovie = try? Movie(json:movie){
                            movieList.append(newmovie)
                            
                            completion(movieList)
                        }
                    }
                }
                else {
                    print("error cause: ",response.result.error!)
                }
        }
    }
    
    func fetchUpcomingMovies(completion:@escaping(_ movieList:[Movie]) -> ()){
        
        let url = "https://api.themoviedb.org/3/movie/upcoming?api_key=7984d2ca0e6fe87cb9bc7eb403df05eb&language=en-US&page=1"
        Alamofire.request(url)
            .responseJSON{ (response) in
                if let json = response.result.value as? [String: Any],
                    let movies = json["results"] as? [[String: Any]] {
                    var movieList = [Movie]()
                    for movie in movies{
                        if let newmovie = try? Movie(json:movie){
                            movieList.append(newmovie)
                             completion(movieList)
                        }
                    }
                }
                else {
                    print("error cause: ",response.result.error!)
                }
            }
            
           
    }
    
    func fetchRecentMovies(completion:@escaping(_ movieList:[Movie]) -> ()){
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=7984d2ca0e6fe87cb9bc7eb403df05eb&language=en-US&page=1"
        Alamofire.request(url)
            .responseJSON{ (response) in
                if let json = response.result.value as? [String: Any],
                    let movies = json["results"] as? [[String: Any]],
                    let total = json["total_pages"] as? Int,
                    let page = json["page"] as? Int{
                    //print(total, page)
                    var movieList = [Movie]()
                    for movie in movies{
                        if let newmovie = try? Movie(json:movie){
                            movieList.append(newmovie)
                            completion(movieList)
                        }
                    }
                }
                else {
                    print("error cause: ",response.result.error!)
                }
        }
    }

}
