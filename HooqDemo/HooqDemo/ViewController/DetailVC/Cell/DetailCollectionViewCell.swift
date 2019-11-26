//
//  DetailCollectionViewCell.swift
//  HooqDemo
//
//  Created by Gagan on 3/3/2019.
//  Copyright © 2018 Gagan. All rights reserved.
//

import Foundation
import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: CustomImageView!

    struct Constants {
        static let CellReuseID = "kDetailCellectionCell"
        static let NibName     = "DetailCollectionViewCell"
    }
    
    class var nibName : String {  return Constants.NibName }
    class var cellReuseID : String {  return Constants.CellReuseID } 
    
    override func prepareForReuse() {
        imgView.image = nil
    }
    
    func setupCellData(_ value : MovieList?)  {
        
        guard let poster = value?.poster_path else {
            imgView.image = UIImage(named:GlobalConstants.noImage)
            return
        }
        
        DispatchQueue.main.async {
            let imagestr = String(format: "%@%@", GlobalConstants.homeImageURL, poster)
            self.imgView.loadImageUsingUrlString(imagestr)
        }
    }
}
