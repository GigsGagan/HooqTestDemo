//
//  DetailViewController.swift
//  HooqDemo
//
//  Created by Gagan on 3/3/2019.
//  Copyright © 2018 Gagan. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: CustomImageView!
    @IBOutlet weak var movieImageView: CustomImageView!
    @IBOutlet weak var movieDescLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    
    let loadinScreen = LoadingView.newInstance()
    let manager = DetailViewModel()
    var currentMovie: MovieList?

    // MARK:- AppLifecyle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        allocateObjects()
    }
    
    // MARK: - Private Methods
    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        loadinScreen.show()
        manager.delegate = self
        detailTableView.register(UINib(nibName: DetailTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.cellReuseID)
    }
    
    func allocateObjects() {
        
        guard let movie = currentMovie else { return }
        movieNameLabel.text = movie.title
        movieDateLabel.text = movie.release_date
        movieDescLabel.text = movie.overview
        
        if let id = movie.id {
            manager.loadContentForSimilarMoviesList(id)
        }
        
        guard let poster = movie.poster_path else {
            movieImageView.image = UIImage(named:GlobalConstants.noImage)
            return
        }
        
        let imagestr = String(format: "%@%@", GlobalConstants.detailImageURL, poster)
        movieImageView.loadImageUsingUrlString(imagestr)
        backgroundImageView.loadImageUsingUrlString(imagestr)
    }
   
}

// MARK: - IBActions
extension DetailViewController {
    @IBAction func closePressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableView Delegates & DataSource
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.cellReuseID, for: indexPath) as? DetailTableViewCell
        cell?.setupCollectionView(value: manager.similarMovieArray)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

//MARK:- DetailViewModelDelegate Protocol Methods
extension DetailViewController: DetailViewModelDelegate {
    
    func didUpdateList() {
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.reloadData()
        
        if let tbHeight = detailTableView.tableHeaderView?.frame.size.height {
             self.detailTableView.tableHeaderView?.frame.size.height = tbHeight + self.movieDescLabel.bounds.size.height
        }
        self.loadinScreen.hide()
    }
    
    func didUpdateErrorWithAlert(error: String) {
        self.showAlertPopUp(message: error)
        self.loadinScreen.hide()
    }
    
}

//MARK:- DetailTableViewCellDelegate Protocol Methods
extension DetailViewController: DetailTableViewCellDelegate {
   
    func didNavigate(value: MovieList?) {
        guard let value = value else { return }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.currentMovie = value
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
}
