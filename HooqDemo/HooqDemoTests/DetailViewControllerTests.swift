//
//  DetailViewControllerTests.swift
//  HooqDemoUITests
//
//  Created by Gagan on 1/3/2019.
//  Copyright © 2018 Gagan. All rights reserved.
//

import XCTest
@testable import HooqDemo

class DetailViewControllerTests: XCTestCase {
    
    var instance = DetailViewController()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        instance = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
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
        XCTAssertNotNil(instance.setupUI())
        XCTAssertNotNil(instance.manager)
        XCTAssertNotNil(instance.didUpdateList())
        XCTAssertNotNil(instance.didUpdateErrorWithAlert(error: ""))
        XCTAssertNotNil(instance.allocateObjects())

    }
    
    func testTablereload(){
        XCTAssertNotNil(instance.detailTableView.reloadData())
    }
    
    func testTableviewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(instance.detailTableView)
    }
    
    func testConformsTotableViewDataSource() {
        
        XCTAssert(instance.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(instance.responds(to: #selector(instance.detailTableView.dataSource?.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(instance.responds(to: #selector(instance.detailTableView.dataSource?.tableView(_:cellForRowAt:))))
        
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
