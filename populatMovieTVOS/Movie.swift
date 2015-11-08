//
//  Movie.swift
//  populatMovieTVOS
//
//  Created by Miwand Najafe on 2015-11-05.
//  Copyright © 2015 Miwand Najafe. All rights reserved.
//

import Foundation

class Movie {
    
    let urlBase = "http://image.tmdb.org/t/p/w500"
    
    var title: String!
    var overview:String!
    var posterPath:String!
    var rating:String!
    var releaseDate:String!
    
    init(movieDict: Dictionary<String, AnyObject>){
        if let title = movieDict["original_title"] as? String {
            self.title = title
        }
        if let overview = movieDict["overview"] as? String {
            self.overview = overview
        }
        if let path = movieDict["poster_path"] as? String {
            self.posterPath = "\(urlBase)\(path)"
        }
        if let rating = movieDict["vote_average"] as? Float {
            let ratingString = String(format: "%.2f", rating)
            self.rating = ratingString
        }
        if let releaseDate = movieDict["release_date"] as? String {
            self.releaseDate = releaseDate
        }
        
        
    }
}