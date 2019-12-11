//
//  TVShowViewController.swift
//  EpisodesFromOnline
//
//  Created by Kelby Mittan on 12/10/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class TVShowViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        loadShows()
    }
    
    var showArr = [Shows]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet {
            if !searchQuery.isEmpty {
                TVShowSearchAPI.fetchShows(for: searchQuery) { (result) in
                    switch result {
                    case .failure(let appError):
                        print(appError)
                    case .success(var shows):
                        shows = shows.sorted { $0.name < $1.name }
                        self.showArr = shows.filter { $0.name.lowercased().contains(self.searchQuery.lowercased()) }
                    }
                }
            }
        }
    }
    
    

    func loadShows() {
        searchQuery = "seinfeld"
        
        TVShowSearchAPI.fetchShows(for: searchQuery) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(var shows):
                shows = shows.sorted { $0.name < $1.name }
                self.showArr = shows.filter { $0.name.lowercased().contains(self.searchQuery.lowercased()) }
            }
        }
        print(showArr.count)
    }

}

extension TVShowViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tvShowCell", for: indexPath) as? ShowsTableViewCell else {
            fatalError()
        }
        
        let show = showArr[indexPath.row]
        
        cell.configureCell(for: show)
        
        return cell
    }
}

extension TVShowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
