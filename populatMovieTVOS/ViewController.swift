//
//  ViewController.swift
//  populatMovieTVOS
//
//  Created by Miwand Najafe on 2015-11-04.
//  Copyright © 2015 Miwand Najafe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView:UICollectionView!
    //293,475
    
    let defaultSize = CGSize(width: 293, height: 475)
    let selectSize = CGSize(width: 323, height: 525)
    
    var movies = [Movie]()
    
    let urlBase = "http://api.themoviedb.org/3/movie/popular?api_key=ff743742b3b6c89feb59dfc138b4c12f"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        downloadData()
    }

    func downloadData() {
        let url = NSURL(string: urlBase)!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error != nil {
                print(error)
            } else {
                do {
                let dict = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as? Dictionary<String, AnyObject>
                    
                    
                    if let results = dict!["results"] as? [Dictionary<String,AnyObject>] {
                        print(results)
                        for obj in results {
                            let movie = Movie(movieDict: obj)
                            self.movies.append(movie)
                        }
                        dispatch_async(dispatch_get_main_queue()){
                        self.collectionView.reloadData()
                        }
                    }
                } catch {
                    
                }
            }
            
        }
        task.resume()
    }
  

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("movieCell", forIndexPath: indexPath) as? MovieCell {
            let movie  = movies[indexPath.row]
            cell.configCell(movie)
            
            if cell.gestureRecognizers?.count == nil {
                let tap = UITapGestureRecognizer(target: self, action: "tapped:")
                tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
                cell.addGestureRecognizer(tap)
            }
            
            return cell
        } else {
          return MovieCell()  
        }
    }
    
    
    func tapped(gesture:UIGestureRecognizer){
        if let cell = gesture.view as? MovieCell {
            //load the next view controller and pass in the movie
            print("tap detected")
        }
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(337, 535)
        
    }
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if let prev = context.previouslyFocusedView as? MovieCell {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                prev.movieImage.frame.size = self.defaultSize
            })
            if let next = context.nextFocusedView as? MovieCell {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    next.movieImage.frame.size = self.selectSize
                })
            }
        }
        
    }

}

