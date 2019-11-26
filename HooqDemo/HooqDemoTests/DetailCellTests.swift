//
//  DetailCellTests.swift
//  HooqDemoTests
//
//  Created by Gagan on 1/3/2019.
//  Copyright © 2018 Gagan. All rights reserved.
//

import XCTest
@testable import HooqDemo

class DetailCellTests: XCTestCase {

    var instance = DetailTableViewCell()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    /////////////////////////
    func testSUT_CanInstantiateViewController() {
        
        XCTAssertNotNil(instance)
        XCTAssertNotNil(instance.awakeFromNib())
        XCTAssertNotNil(instance.similarMoviesArray)
        
    }
    
    func testSUT_ConformsToCollectionViewDataSource() {
        
        XCTAssert(instance.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(instance.responds(to: #selector(instance.similarMovieCollectionView.dataSource?.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(instance.responds(to: #selector(instance.similarMovieCollectionView.dataSource?.collectionView(_:cellForItemAt:))))
    }

    
    func testSUT_ConformsToCollectionViewDelegate() {
        XCTAssert(instance.conforms(to: UICollectionViewDelegate.self))
        XCTAssertTrue(instance.responds(to: #selector(instance.similarMovieCollectionView.delegate?.collectionView(_:didSelectItemAt:))))
        XCTAssertTrue(instance.responds(to: #selector(instance.similarMovieCollectionView.delegate?.collectionView(_:didSelectItemAt:))))
        
    }
    
    func testSUT_ConformsToCollectionViewDelegateFlowLayout () {
        XCTAssert(instance.conforms(to: UICollectionViewDelegateFlowLayout.self))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
