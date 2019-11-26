//
//  HomeViewControllerTests.swift
//  HooqDemoTests
//
//  Created by Gagan on 1/3/2019.
//  Copyright © 2018 Gagan. All rights reserved.
//

import XCTest
@testable import HooqDemo

class HomeViewControllerTests: XCTestCase {
    
    var instance = HomeViewController()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        instance = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        //load view hierarchy
        _ = instance.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSUT_CanInstantiateViewController() {
        
        XCTAssertNotNil(instance)
        XCTAssertNotNil(instance.viewDidLoad())
        XCTAssertNotNil(instance.viewWillAppear(true))
        XCTAssertNotNil(instance.refreshTableView())
        XCTAssertNotNil(instance.manager)
        XCTAssertNotNil(instance.didUpdateList())
        XCTAssertNotNil(instance.didUpdateErrorWithAlert(error: ""))
    }
    
    func testCollectionreload(){
        XCTAssertNotNil(instance.movieCollectionView.reloadData())
    }
    
    func testCollectionViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(instance.movieCollectionView)
    }
    
    func testSUT_ShouldSetCollectionViewDataSource() {
        
        XCTAssertNotNil(instance.movieCollectionView.dataSource)
    }
    
    func testSUT_ConformsToCollectionViewDataSource() {
        
        XCTAssert(instance.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(instance.responds(to: #selector(instance.movieCollectionView.dataSource?.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(instance.responds(to: #selector(instance.movieCollectionView.dataSource?.collectionView(_:cellForItemAt:))))
        
    }
    
    func testSUT_ShouldSetCollectionViewDelegate() {
        XCTAssertNotNil(instance.movieCollectionView.delegate)
    }
    
    func testSUT_ConformsToCollectionViewDelegate() {
        XCTAssert(instance.conforms(to: UICollectionViewDelegate.self))
        XCTAssertTrue(instance.responds(to: #selector(instance.movieCollectionView.delegate?.collectionView(_:didSelectItemAt:))))
        XCTAssertTrue(instance.responds(to: #selector(instance.movieCollectionView.delegate?.collectionView(_:willDisplay:forItemAt:))))
        XCTAssertTrue(instance.responds(to: #selector(instance.movieCollectionView.delegate?.collectionView(_:didSelectItemAt:))))
        
    }
    
    func testSUT_ConformsToCollectionViewDelegateFlowLayout () {
        XCTAssert(instance.conforms(to: UICollectionViewDelegateFlowLayout.self))
    }
    
    func testSUT_checkErrorAlert(){
        let alertString = ""
        XCTAssertNotNil(instance.didUpdateErrorWithAlert(error :alertString))
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
}
