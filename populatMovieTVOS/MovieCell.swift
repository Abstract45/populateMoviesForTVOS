//
//  MovieCell.swift
//  populatMovieTVOS
//
//  Created by Miwand Najafe on 2015-11-05.
//  Copyright © 2015 Miwand Najafe. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    
    func configCell(movie:Movie){
        if let title = movie.title {
            movieLabel.text = title
        }
        
        if let path = movie.posterPath {
            let url = NSURL(string: path)!
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
              let data = NSData(contentsOfURL: url)!
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let img = UIImage(data: data)
                    self.movieImage.image = img
                })
            }
        }
    }
}
