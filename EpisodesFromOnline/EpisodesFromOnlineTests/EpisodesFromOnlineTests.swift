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
    
    func testShows() {
        
        let searchQuery = "seinfeld".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let exp = XCTestExpectation(description: "searches found")
        let showsEndpointURL = "https://api.tvmaze.com/singlesearch/shows?q=\(searchQuery)&embed=episodes"
        
        let request = URLRequest(url: URL(string: showsEndpointURL)!)
        
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
    
    func testShowCount() {
        
        let searchQuery = "seinfeld".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let exp = XCTestExpectation(description: "searches found")
        let episodesEndpointURL = "https://api.tvmaze.com/search/shows?q=\(searchQuery)"
        
        let request = URLRequest(url: URL(string: episodesEndpointURL)!)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("\(appError)")
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode([TVShowSearch].self, from: data)
                    let showArr = searchResults.map { $0.show }
                    
                    XCTAssertEqual(showArr.count, 2, "Should be 2")
                } catch {
                    XCTFail()
                }
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    func testEpisodes() {
        let id = "530".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let exp = XCTestExpectation(description: "searches found")
        let episodesEndpointURL = "https://api.tvmaze.com/shows/\(id)/episodes"
        
        let request = URLRequest(url: URL(string: episodesEndpointURL)!)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("\(appError)")
            case .success(let data):
                exp.fulfill()
                XCTAssertGreaterThan(data.count, 98000, "should be \(data.count)")
            }
        }
        wait(for: [exp], timeout: 5.0)
    }
}


