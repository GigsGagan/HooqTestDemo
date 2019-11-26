//
//  APIManagerTests.swift
//  HooqDemoTests
//
//  Created by Gagan on 1/3/2019.
//  Copyright © 2018 Gagan. All rights reserved.
//

import XCTest
@testable import HooqDemo


class APIManagerTests: XCTestCase {
    
    var apiManager = APIManager.shared()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testFetchMovies() {
        
        let expect = XCTestExpectation(description: "trigger")
        apiManager.fetchAllMoviesApiRequest(1) { (success, response, pagecount, error) in
            if success {
                expect.fulfill()
                XCTAssertNotNil(response)
                
            } else {
                XCTFail()
            }
        }
        
        wait(for: [expect], timeout: 20.0)
    }
    
    func testFetchsimilarMovies() {
        
        let expect = XCTestExpectation(description: "trigger")
        apiManager.fetchSimilarMoviesApiRequest(192) { (success, response, error)  in
            if success {
                expect.fulfill()
                XCTAssertNotNil(response)
                
            } else {
                XCTFail()
            }
        }
        
        wait(for: [expect], timeout: 20.0)
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
