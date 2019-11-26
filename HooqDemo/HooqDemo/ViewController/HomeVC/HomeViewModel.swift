//
//  HomeViewModel.swift
//  HooqDemo
//
//  Created by Gagan on 1/3/2010.
//  Copyright © 2018 Gagan. All rights reserved.
//

import Foundation
import UIKit

public protocol HomeViewModelDelegate: class {
    
    func didUpdateList()
    func didUpdateErrorWithAlert( error: String)
}

class HomeViewModel: NSObject {
    
    weak var delegate: HomeViewModelDelegate?
    let apiInstance = APIManager()
    
    var movieListArray:[MovieList] = [MovieList]()
    
    var pageNo: Int = 1
    var totalPages: Int = 0
    
    override init() {
        super.init()
        loadContentForMoviesList()
    }
    
    func fetchMore () {
        if pageNo < totalPages {
            pageNo += 1
            loadContentForMoviesList()
        }
    }
    
    func loadContentForMoviesList() {
        
        apiInstance.fetchAllMoviesApiRequest(pageNo) { (success, json, pageCount, error)  in
            if success {
                
                guard let response = json else { return }
                
                self.totalPages = pageCount
                if self.pageNo == 1 {
                    self.movieListArray = [MovieList]()
    
                }
                
                for value in response {
                    self.movieListArray.append(value)
                }
                
                DispatchQueue.main.async {
                    self.delegate?.didUpdateList()
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate?.didUpdateErrorWithAlert(error: error!)
                }
            }
        }
        
    }//end
    
    
}
