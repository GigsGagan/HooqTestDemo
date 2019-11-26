//
//  Results.swift
//  HooqDemo
//
//  Created by Gagan on 1/3/2019.
//  Copyright © 2018 Gagan. All rights reserved.
//

import Foundation
import UIKit

struct Results: Codable {
    var results: [MovieList]
    var total_pages: Int
}

struct MovieList: Codable {
    var title: String?
    var id : NSInteger?
    var poster_path : String?
    var overview : String?
    var release_date : String?
}
