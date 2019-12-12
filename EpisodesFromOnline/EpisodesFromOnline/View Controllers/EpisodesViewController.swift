//
//  EpisodesViewController.swift
//  EpisodesFromOnline
//
//  Created by Kelby Mittan on 12/10/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        loadEpisodes(for: showSelected?.id?.description ?? "530")
    }
    
    var episodes = [Episode]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var showSelected: Shows?
    
    func loadEpisodes(for show: String) {
        EpisodeAPIClient.fetchEpisodes(for: show) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let episodes):
                self?.episodes = episodes
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let episodeVC = segue.destination as? EpisodeDetailController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("could not load")
        }
        episodeVC.episode = episodes[indexPath.row]
    }

    
}

extension EpisodesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodeCell else {
            fatalError()
        }
        
        let episode = episodes[indexPath.row]
        
        cell.configureCell(for: episode)
        
        return cell
    }
}

extension EpisodesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
