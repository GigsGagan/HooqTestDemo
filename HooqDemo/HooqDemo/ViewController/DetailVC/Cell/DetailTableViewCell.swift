//
//  DetailTableViewCell.swift
//  HooqDemo
//
//  Created by Gagan on 3/3/2019.
//  Copyright © 2018 Gagan. All rights reserved.
//

import Foundation
import UIKit

protocol DetailTableViewCellDelegate: class {
    func didNavigate(value: MovieList?)
}

class DetailTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var similarLabel: UILabel!
    @IBOutlet weak var similarMovieCollectionView: UICollectionView!
    weak var delegate: DetailTableViewCellDelegate?
    
    var similarMoviesArray:[MovieList] = [MovieList]()
    
    class var nibName : String { return Constants.NibName }
    class var cellReuseID : String { return Constants.CellReuseID }
    
    struct Constants {
        static let CellReuseID = "kDetailTableCell"
        static let NibName     = "DetailTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK:- Private Methods
    func setupCollectionView(value : [MovieList]) {
        
        if value.isEmpty {
            similarLabel.isHidden = true
            return
        }
        
        similarMoviesArray = value
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        similarMovieCollectionView.setCollectionViewLayout(layout, animated: true)
        let cellNib = UINib(nibName: DetailCollectionViewCell.nibName, bundle: nil)
        similarMovieCollectionView.register(cellNib, forCellWithReuseIdentifier: DetailCollectionViewCell.cellReuseID)
        
        similarMovieCollectionView.dataSource = self
        similarMovieCollectionView.delegate = self
        similarMovieCollectionView.reloadData()
    }
}

// MARK:- Collection View
extension DetailTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMoviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.cellReuseID, for: indexPath) as! DetailCollectionViewCell
        cell.setupCellData(similarMoviesArray[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didNavigate(value: similarMoviesArray[indexPath.row])
    }
    
}
