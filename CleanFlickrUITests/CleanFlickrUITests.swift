//
//  CleanFlickrUITests.swift
//  CleanFlickrUITests
//
//  Created by inigo on 27/08/2018.
//  Copyright © 2018 Iñigo. All rights reserved.
//

import XCTest

class CleanFlickrUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        app = XCUIApplication()
        // We send a command line argument to our app,
        // to enable it to reset its state
        app.launchArguments.append("--uitesting")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInputSearchAndGettingResults()
    {
        app.launch()
        app.statusBars.children(matching: .other).element.children(matching: .other).element(boundBy: 0).tap()
        app.searchFields["Search"].tap()
        app.keys["I"].tap()
        app.keys["n"].tap()
        app.keys["d"].tap()
        app.keys["i"].tap()
        app.keys["g"].tap()
        app.keys["o"].tap()
        app.buttons["Search"].tap()
//        app.otherElements["Hotel Indigo"].tap()
//        let backToTheMap = app.navigationBars["CleanFlickr.PhotoDetailView"].buttons["Flickr image search"]
//        backToTheMap.tap()
//        let map = app.otherElements["PopoverDismissRegion"]
//        map.tap()
//        backToTheMap.tap()
//        map.swipeLeft()
//        sleep(3)
//        app.otherElements["Wuppertal"].tap()
//        sleep(3)
    }
    
}
