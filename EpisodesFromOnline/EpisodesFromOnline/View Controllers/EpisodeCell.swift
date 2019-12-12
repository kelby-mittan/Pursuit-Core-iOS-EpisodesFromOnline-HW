//
//  EpisodeCell.swift
//  EpisodesFromOnline
//
//  Created by Kelby Mittan on 12/11/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {

    @IBOutlet var episodeImage: UIImageView!
    @IBOutlet var episodeTitleLabel: UILabel!
    @IBOutlet var seasonEpisodeLabel: UILabel!
    
    
    
    func configureCell(for episode: Episode) {
        
        
        guard let validImage = episode.image?.medium, let season = episode.season, let number = episode.number else {
            return
        }

        episodeTitleLabel.text = episode.name
        
        seasonEpisodeLabel.text = "S: \(season.description) E: \(number.description)"
        
        ImageClient.fetchImage(for: validImage) { [weak self] (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.episodeImage.image = image
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }

}
