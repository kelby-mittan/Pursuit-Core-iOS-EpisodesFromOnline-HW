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
    
    
    
    func configureCell(for episode: Episode,shows: Shows) {
        
        guard let season = episode.season, let number = episode.number else {
            return
        }
        
        episodeTitleLabel.text = episode.name
        
        seasonEpisodeLabel.text = "S: \(season.description) E: \(number.description)"
        
        let defaultImage = UIImage(systemName: "exclamationmark.triangle")
        
        let validImage = episode.image?.medium ?? shows.image?.medium ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaBEWb6S_3uxUFTVBDm3r0QrEELsC_q374IEhQktjZakD_1nqqNw&s"
        
        ImageClient.fetchImage(for: validImage) { [weak self] (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.episodeImage.image = image
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.episodeImage.image = defaultImage
                }
                print("error \(error)")
            }
        }
        
        if validImage != episode.image?.medium {
            episodeImage.contentMode = .scaleAspectFit
        }
    }
    
}
