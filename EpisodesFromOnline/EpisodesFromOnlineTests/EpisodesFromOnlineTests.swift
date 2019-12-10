//
//  EpisodesFromOnlineTests.swift
//  EpisodesFromOnlineTests
//
//  Created by Kelby Mittan on 12/9/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import XCTest
@testable import EpisodesFromOnline

class EpisodesFromOnlineTests: XCTestCase {

    func testEpisodes() {
        
        let searchQuery = "seinfeld".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let exp = XCTestExpectation(description: "searches found")
        let episodesEndpointURL = "https://api.tvmaze.com/singlesearch/shows?q=\(searchQuery)&embed=episodes"
        
        let request = URLRequest(url: URL(string: episodesEndpointURL)!)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("\(appError)")
            case .success(let data):
                exp.fulfill()
                XCTAssertGreaterThan(data.count, 10000, "should be \(data.count)")
            }
        }
        wait(for: [exp], timeout: 5.0)
        
    }

}
