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
    let defaultSize = CGSize(width: 337, height: 535)
    let selectSize = CGSize(width: 340, height: 555)
    let defltLabelSize = CGSize(width: 337, height: 36)
    let slctLabelSize = CGSize(width: 340, height: 56)
    
    
    var movies = [Movie]()
    var indexValue = NSIndexPath()
    
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
                        for obj in results {
                            let movie = Movie(movieDict: obj)
                            self.movies.append(movie)
                        }
                        dispatch_async(dispatch_get_main_queue()){
                            self.collectionView.reloadData()
                        }
                    }
                } catch let err as NSError{
                    print(err.debugDescription)
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
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapped(_:)))
                
                tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
                cell.addGestureRecognizer(tap)
            }
            
            return cell
        } else {
            return MovieCell()
        }
    }
    func tapped(gesture:AnyObject?){
        if let cell = gesture?.view as? MovieCell {
            
            indexValue = collectionView.indexPathForItemAtPoint(cell.frame.origin)!
            
            performSegueWithIdentifier("detailVC", sender: gesture)
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailVC" {
            if let destinationVC = segue.destinationViewController as? DetailVC {
                destinationVC.movieDetail = movies[(indexValue.row)]
            }
        }
    }
}

