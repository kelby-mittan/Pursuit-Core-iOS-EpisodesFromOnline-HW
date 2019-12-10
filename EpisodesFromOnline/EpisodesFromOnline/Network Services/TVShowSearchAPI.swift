//
//  TVShowSearchAPI.swift
//  EpisodesFromOnline
//
//  Created by Kelby Mittan on 12/10/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation


struct TVShowSearchAPI {
    static func fetchShows(for searchQuery: String, completion: @escaping (Result<[Episode], AppError>) -> ()) {
        
        // "http://api.tvmaze.com/singlesearch/shows?q=\(searchQuery)&embed=episodes"
        
        let showEndpointURL = "https://api.tvmaze.com/singlesearch/shows?q=seinfeld&embed=episodes"
        
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
                    let searchResults = try JSONDecoder().decode(TVShowSearch.self, from: data)
                    let episodeArr = searchResults.embedded.map { $0.episodes }
                    completion(.success(episodeArr))
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
}
