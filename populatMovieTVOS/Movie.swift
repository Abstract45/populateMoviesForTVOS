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
        
    }
}