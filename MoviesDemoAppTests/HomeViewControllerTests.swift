//
//  HomeViewControllerTests.swift
//  MoviesDemoAppTests
//
//  Created by sudhakar reddy on 16/10/19.
//  Copyright © 2019 sudhakar reddy. All rights reserved.
//

import XCTest

@testable import MoviesDemoApp

class HomeViewControllerTests: XCTestCase {
    var viewModel: NowPlayingViewModel? = NowPlayingViewModel(networkManager: ServiceManager())
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        viewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotNil(viewModel?.movieDataResult)
        XCTAssertTrue((viewModel?.shouldLoadMoreData(totalPage: viewModel?.totalPages ?? 1,
                                                     totalPageLoaded: viewModel?.page ?? 1))!)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAsynchronousURLConnection() {
        let URL = "https://api.themoviedb.org/3/movie/now_playing?page=1&api_key=22cdabfafc0962e9230ac1f8a9b4d01c"
        let objExpectation: XCTestExpectation = expectation(description: "GET \(URL)")
        viewModel?.networkManager.getNowPlayingListData(page: viewModel?.page ?? 1, completion: { (data, error) in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            self.viewModel?.movieDataResult += data?.movieResults ?? self.viewModel!.movieDataResult
            XCTAssertTrue(((self.viewModel?.page +=  1) != nil))
            XCTAssertNotNil(self.viewModel?.movieDataResult, "Array Should not be nil")
            objExpectation.fulfill()
        })
        // put timeout as per your expectation
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
