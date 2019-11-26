//
//  HomeViewController.swift
//  HooqDemo
//
//  Created by Gagan on 1/3/2019.
//  Copyright © 2018 Gagan. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    let manager = HomeViewModel()
    let loadinScreen = LoadingView.newInstance()
    var pullToRefresh: UIRefreshControl? = nil
    
    // MARK:- AppLifecyle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    func setupUI() {
        loadinScreen.show()
        title = "Home"
        manager.delegate = self
        
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        
        pullToRefresh = UIRefreshControl()
        pullToRefresh?.tintColor = UIColor.black
        pullToRefresh?.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        movieCollectionView.addSubview(pullToRefresh!)
    }
    
    @objc func refreshTableView(){
        manager.loadContentForMoviesList()
    }
    
}

// MARK: - UICollectionView Delegates & DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.movieListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as! HomeCollectionCell
        cell.setupCountry(manager.movieListArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = (collectionView.bounds.width/3.0)-1
        let yourHeight = yourWidth+45
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (manager.movieListArray.count - 1) {
            manager.fetchMore()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.currentMovie = manager.movieListArray[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//MARK:- HomeViewModelDelegate Protocol Methods
extension HomeViewController : HomeViewModelDelegate {
    
    func didUpdateList() {
        self.movieCollectionView.reloadData()
        self.pullToRefresh?.endRefreshing()
        self.loadinScreen.hide()
    }
    
    func didUpdateErrorWithAlert(error: String) {
        self.showAlertPopUp(message: error)
        self.loadinScreen.hide()
    }
    
}



