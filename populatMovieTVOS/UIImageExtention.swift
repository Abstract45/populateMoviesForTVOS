//
//  UIImageExtention.swift
//  populatMovieTVOS
//
//  Created by Miwand Najafe on 2015-11-08.
//  Copyright © 2015 Miwand Najafe. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                guard let imageData = data as NSData? else {
                    return
                }
                self.image = UIImage(data: imageData)
                
            }
        }
    }
}
