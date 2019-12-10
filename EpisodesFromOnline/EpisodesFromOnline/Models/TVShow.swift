//
//  TVShow.swift
//  EpisodesFromOnline
//
//  Created by Kelby Mittan on 12/10/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation

struct TVShowSearch: Decodable {
    let embedded: [Shows]
    let name: String
    let image: Image
    
    private enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case name
        case image
    }
}

struct Image: Decodable {
    let medium: String
    let original: String
}

struct Shows: Decodable {
    let episodes: Episode    
}

struct Episode: Decodable {
    let name: String
}
