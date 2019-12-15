//
//  ShowsTableViewCell.swift
//  EpisodesFromOnline
//
//  Created by Kelby Mittan on 12/10/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class ShowsTableViewCell: UITableViewCell {
    
    @IBOutlet var showImage: UIImageView!
    @IBOutlet var showLabel: UILabel!
    
    func configureCell(for show: Shows) {
        
        showLabel.text = show.name
        
        let defaultImage = UIImage(systemName: "exclamationmark.triangle")
        let tvImage = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaBEWb6S_3uxUFTVBDm3r0QrEELsC_q374IEhQktjZakD_1nqqNw&s"
       
        let validImage = show.image?.medium ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaBEWb6S_3uxUFTVBDm3r0QrEELsC_q374IEhQktjZakD_1nqqNw&s"
        
        ImageClient.fetchImage(for: validImage) { [weak self] (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.showImage.image = image
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showImage.image = defaultImage
                }
                print("error \(error)")
            }
        }
        
        if validImage == tvImage {
            showImage.contentMode = .scaleAspectFit
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        showImage.image = nil
    }
}
