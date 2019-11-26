//
//  DetailViewModel.swift
//  HooqDemo
//
//  Created by Gagan on 3/3/2019.
//  Copyright © 2018 Gagan. All rights reserved.
//

import Foundation
import UIKit

public protocol DetailViewModelDelegate: class {
    
    func didUpdateList()
    func didUpdateErrorWithAlert( error: String)
}

class DetailViewModel: NSObject {
    
    weak var delegate: DetailViewModelDelegate?
    let apiInstance = APIManager()
    
    var similarMovieArray:[MovieList] = [MovieList]()
    
    override init() {
        super.init()
    }
    
    func loadContentForSimilarMoviesList(_ id: NSInteger) {
        
        apiInstance.fetchSimilarMoviesApiRequest(id) { (success, json, error) in
         
            if success {
                
                guard let response = json else { return }
                
                for value in response {
                    self.similarMovieArray.append(value)
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
