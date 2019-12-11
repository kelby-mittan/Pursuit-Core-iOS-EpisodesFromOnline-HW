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
        
        
        guard let validImage = show.image?.medium else {
            return
        }
        
        showLabel.text = show.name
        
        ImageClient.fetchImage(for: validImage) { [weak self] (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.showImage.image = image
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }

}