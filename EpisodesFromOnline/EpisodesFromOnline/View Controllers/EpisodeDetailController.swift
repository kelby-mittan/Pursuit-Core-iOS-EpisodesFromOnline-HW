//
//  EpisodeDetailController.swift
//  EpisodesFromOnline
//
//  Created by Kelby Mittan on 12/11/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class EpisodeDetailController: UIViewController {
    @IBOutlet var largeImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var seasonNumberLabel: UILabel!
    @IBOutlet var summaryTextView: UITextView!
    
    var theEpisode: Episode?
    var theShow: Shows?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI(episode: theEpisode, show: theShow)
    }
    
    func updateUI(episode: Episode?, show: Shows?){
        
        var summary = episode?.summary
        summary = summary?.replacingOccurrences(of: "<p>", with: "")
        summary = summary?.replacingOccurrences(of: "</p>", with: "")
          
        nameLabel.text = episode?.name
        seasonNumberLabel.text = "Season: \(episode?.season?.description ?? "") Episode: \(episode?.number?.description ?? "")"
        
        if summary != nil {
            summaryTextView.text = summary
        } else {
            summaryTextView.text = "No summary provided"
        }
        
        let defaultImage = UIImage(systemName: "exclamationmark.triangle")
        
        let validImage = episode?.image?.original ?? show?.image?.medium ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaBEWb6S_3uxUFTVBDm3r0QrEELsC_q374IEhQktjZakD_1nqqNw&s"
        
            ImageClient.fetchImage(for: validImage) { [weak self] (result) in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.largeImage.image = image
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.largeImage.image = defaultImage
                    }
                    print("error \(error)")
                }
            }
        
        if validImage != episode?.image?.original {
            largeImage.contentMode = .scaleAspectFit
        }
    }
}
