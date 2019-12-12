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
    
    var episode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI(){
        
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
        
        if let validImage = episode?.image?.medium {
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
            
        } else {
            largeImage.image = defaultImage
        }
    }

    
}
