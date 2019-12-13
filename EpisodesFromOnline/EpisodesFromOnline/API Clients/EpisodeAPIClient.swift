//
//  EpisodeAPIClient.swift
//  EpisodesFromOnline
//
//  Created by Kelby Mittan on 12/11/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation



class EpisodeAPIClient {
    
    static func fetchEpisodes(for id: String, completion: @escaping (Result<[Episode], AppError>) -> ()) {
                
        let episodeEndpointURL = "https://api.tvmaze.com/shows/\(id)/episodes"
        
        guard let url = URL(string: episodeEndpointURL) else {
            completion(.failure(.badURL(episodeEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    
                    let searchResults = try JSONDecoder().decode([Episode].self, from: data)
                    
                    let showArr = searchResults 
                    
                    completion(.success(showArr))
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
