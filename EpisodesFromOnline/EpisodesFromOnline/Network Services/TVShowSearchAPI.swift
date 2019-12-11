//
//  TVShowSearchAPI.swift
//  EpisodesFromOnline
//
//  Created by Kelby Mittan on 12/10/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation


struct TVShowSearchAPI {
    static func fetchShows(for searchQuery: String, completion: @escaping (Result<[Shows], AppError>) -> ()) {
        
        // "http://api.tvmaze.com/singlesearch/shows?q=\(searchQuery)&embed=episodes"
        // http://api.tvmaze.com/search/shows?q=seinfeld
        
        let showEndpointURL = "https://api.tvmaze.com/search/shows?q=\(searchQuery)"
        
        guard let url = URL(string: showEndpointURL) else {
            completion(.failure(.badURL(showEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    
                    let searchResults = try JSONDecoder().decode([TVShowSearch].self, from: data)
                    
                    let showArr = searchResults.map { $0.show }
                    
                    completion(.success(showArr))
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
}
