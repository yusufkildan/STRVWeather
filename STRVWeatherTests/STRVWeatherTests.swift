//
//  STRVWeatherTests.swift
//  STRVWeatherTests
//
//  Created by yusuf_kildan on 27.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import XCTest
@testable import STRVWeather

class STRVWeatherTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchingCurrentWeather() {
        let promise = self.expectation(description: "Current Weather")
        
        LocationManager.sharedManager.requestCurrentLocation { (location, error) in
            guard error == nil else {
                XCTFail("Failure getting location with error: \(error!.localizedDescription)")
                
                return
            }
            
            NetworkClient.sharedClient.getCurrentWeather(forLocation: location!, completion: { (currentWeather, error) in
                guard error == nil else {
                    XCTFail("Failure getting current weather with error: \(error!.localizedDescription)")
                    
                    return
                }
                
                promise.fulfill()
            })
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchingFiveDayForecast() {
        let promise = self.expectation(description: "Five Day Forecast")
        
        LocationManager.sharedManager.requestCurrentLocation { (location, error) in
            guard error == nil else {
                XCTFail("Failure getting location with error: \(error!.localizedDescription)")
                
                return
            }
            
            NetworkClient.sharedClient.getFiveDayForecast(forLocation: location!, completion: { (dailyForecasts, error) in
                guard error == nil else {
                    XCTFail("Failure getting five day forecast with error: \(error!.localizedDescription)")
                    
                    return
                }
                
                XCTAssertFalse(dailyForecasts!.isEmpty, "List does not contain any items")
                
                promise.fulfill()
            })
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
