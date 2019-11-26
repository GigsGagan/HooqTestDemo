//
//  APIManager.swift
//  HooqDemo
//
//  Created by Gagan on 1/3/2019.
//  Copyright © 2018 Gagan. All rights reserved.
//

import Foundation

class APIManager {
    
    struct ApiRequest {
        static let BaseURL = "https://api.themoviedb.org/3/movie/"
        static let apiKey = "6ea76afacd0f5eaf9787313abed241c4"
        static let langauge = "en-US"
        static let page = "1"
    }
    
    class func shared() -> APIManager {
        return APIManager()
    }
    
    // MARK:- API Method
    func fetchAllMoviesApiRequest(_ pagelimit: Int, completed:@escaping (_ success: Bool, _ response: [MovieList]?, _ pageCount: Int,_ error: String?) -> Void)  {
        
        let urlString = "\(ApiRequest.BaseURL)now_playing?api_key=\(ApiRequest.apiKey)&language=\(ApiRequest.langauge)&page=\(pagelimit)"
        
        let url: URL = URL(string: urlString)!
        URLSession.shared.dataTask(with: url as URL, completionHandler: {data, response, error -> () in
            
            guard let data = data else { return }
            do {
                
                let courses = try JSONDecoder().decode(Results.self, from: data)
                completed(true, courses.results, courses.total_pages, nil)
                
            } catch let jsonErr {
                completed(false, nil, 0, jsonErr.localizedDescription)
            }
            
        }).resume()
        
    }
    
    func fetchSimilarMoviesApiRequest(_ id: NSInteger,completed:@escaping (_ success: Bool, _ response: [MovieList]?, _ error: String?) -> Void)  {
        
        let urlString = "\(ApiRequest.BaseURL)\(id)/similar?api_key=\(ApiRequest.apiKey)&language=\(ApiRequest.langauge)&page=1"
        
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            guard let data = data else { return }
            do {
                
                let courses = try JSONDecoder().decode(Results.self, from: data)
                completed(true, courses.results, nil)
                
            } catch let jsonErr {
                completed(false, nil, jsonErr.localizedDescription)
            }
            
        }).resume()
        
    }//end
    
}
