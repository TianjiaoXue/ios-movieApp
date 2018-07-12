//
//  RecentMovieViewController.swift
//  Movies
//
//  Created by Tianjiao Xue on 4/23/18.
//  Copyright © 2018 Tianjiao Xue. All rights reserved.
//

import UIKit
import Alamofire


class FilmsNowShowingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var result =  [Movie]()
    
    lazy var refresher:UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.showsScopeBar = true
        searchBar.delegate = self

        fetchRecentMovies() { (movieList) in
            self.result = movieList.sorted(by: { $0.vote_count > $1.vote_count})
            self.tableView.reloadData()
            
    }
       
      
// tableView.refreshControl?.addTarget(self, action: #selector(loadHomeData), for: .valueChanged)
        
    }
    
    @objc func requestData(){
        let deadline = DispatchTime.now() + .microseconds(500)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            self.refresher.endRefreshing()
        }
    }

//    @objc func loadHomeData() {
//        NetworkTool.shareNetworkTool.loadHomeInfo() {(homeItems) in
//            self.recipes = homeItems
//            self.tableView.reloadData()
//            self.tableView.refreshControl?.endRefreshing()
//        }
//    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{return}
        print("searchtexr: ", text)
        fetchMovies(keyword: text) { (movieList) in
            self.result = movieList.sorted(by: { $0.release_date > $1.release_date})
            self.tableView.reloadData()
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{return}
        print("searchtexr: ", text)
        fetchMovies(keyword: text) { (movieList) in
            self.result = movieList.sorted(by: { $0.release_date > $1.release_date})
            print("search result count: ",self.result.count)
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("filmList for row ",result.count)
        print(self.result.count)
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell") as! FilmNowTableViewCell
        let movie = self.result[indexPath.row]
        cell.filmNameLabel.text = movie.original_title
        cell.releaseDateLabel.text = movie.release_date
        cell.ageRatingLabel.text = String(movie.vote_average)
        let poster_path = movie.poster_path
        let imageUrl = "https://image.tmdb.org/t/p/w500/"+poster_path
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!)
        cell.imageView?.image = UIImage(data:data!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let selectedIndex = indexPath.row
        performSegue(withIdentifier: "filmNowDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.movie = result[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func fetchRecentMovies(completion:@escaping(_ movieList:[Movie]) -> ()){
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=7984d2ca0e6fe87cb9bc7eb403df05eb&language=en-US&page=1"
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
    
    func fetchMovies(keyword:String,completion:@escaping(_ movieList:[Movie]) -> ()){
        let url = "https://api.themoviedb.org/3/search/movie?api_key=7984d2ca0e6fe87cb9bc7eb403df05eb&language=en-US&sort_by=release_date.asc&query=\(keyword)&page=1"
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
    
    


   

}
