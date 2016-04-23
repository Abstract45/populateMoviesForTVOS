//
//  DetailVC.swift
//  populatMovieTVOS
//
//  Created by Miwand Najafe on 2015-11-05.
//  Copyright © 2015 Miwand Najafe. All rights reserved.
//

import UIKit

class DetailVC: UIViewController{

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieCategory: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    
    var movieDetail: Movie?
    
    var movieTrailer:String?
    
    func getMovieTrailer() {
        guard let movieId = movieDetail?.movieId else {
            return
        }
       
        guard let url = NSURL(string: "http://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=ff743742b3b6c89feb59dfc138b4c12f") else {
            return
        }
        let request = NSMutableURLRequest(URL: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error != nil {
                print("error could not find that movie")
            } else  {
                do {
                    let dict = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as? Dictionary<String, AnyObject>
                    
                    
                    if let results = dict!["results"] as? [Dictionary<String,AnyObject>] {
                        
                        for obj in results {
                           self.movieTrailer = obj["key"] as? String
                            print(self.movieTrailer)
                        }
                        
                    }
                } catch {
                    
                }
//         movieTrailer = data["key"] as? String
//                print(String(data: data!, encoding: NSUTF8StringEncoding))
            
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovieTrailer()
        
        movieTitle.text = movieDetail?.title!
        movieOverview.text = movieDetail?.overview!
        movieRating.text = "IMDB Rating: " + (movieDetail?.rating!)!
        movieDate.text = movieDetail?.releaseDate!
        
        guard let posterPath = movieDetail?.posterPath else {
            return
        }
        
        movieImage.imageFromUrl(posterPath)
       
        
     
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destinationViewController = segue.destinationViewController as? SampleVideoPlayer {
            destinationViewController.movieTrailer = self.movieTrailer
        }
        
        
        
        
    }


}
