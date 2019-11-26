//
//  CustomImageView.swift
//  HooqDemo
//
//  Created by Gagan on 1/3/2019.
//  Copyright © 2018 Gagan. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()
class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    func loadImageUsingUrlString(_ urlString: String) {
                
        if urlString == GlobalConstants.homeImageURL ||
            urlString == GlobalConstants.detailImageURL {
            self.image = UIImage(named:GlobalConstants.noImage)
            return
        }
        
        imageUrlString = urlString
        guard let url = URL(string: urlString) else { return }
        self.image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
            if error != nil { return }
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: data!) else { return }
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache, forKey: urlString as NSString)
            }
        }).resume()
    }
}
