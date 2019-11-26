//
//  HomeCollectionCell.swift
//  HooqDemo
//
//  Created by Gagan on 2/3/2019.
//  Copyright © 2018 Gagan. All rights reserved.
//

import Foundation
import UIKit

class HomeCollectionCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: CustomImageView!
    
    override func prepareForReuse() {
        movieImageView.image = nil
    }
    
    func setupCountry(_ value : MovieList?)  {
        
        guard let poster = value?.poster_path else {
            movieImageView.image = UIImage(named:GlobalConstants.noImage)
            return
        }
        
        DispatchQueue.main.async {
            let image = String(format: "%@%@", GlobalConstants.homeImageURL, poster)
            self.movieImageView.loadImageUsingUrlString(image)
        }
    }
    
}
