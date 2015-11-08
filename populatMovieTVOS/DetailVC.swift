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
    
   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        movieTitle.text = movieDetail?.title!
        movieOverview.text = movieDetail?.overview!
        movieRating.text = movieDetail?.rating!
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */

}
