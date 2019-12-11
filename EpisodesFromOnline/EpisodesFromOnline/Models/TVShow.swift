//
//  TVShow.swift
//  EpisodesFromOnline
//
//  Created by Kelby Mittan on 12/10/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation

struct TVShowSearch: Decodable {
    let show: Shows
    
    private enum CodingKeys: String, CodingKey {
        case show = "show"
    }
}

struct Shows: Decodable {
    let id: Int?
    let name: String?
    let image: Image?
}

struct Image: Decodable {
    let medium: String?
    let original: String?
}
