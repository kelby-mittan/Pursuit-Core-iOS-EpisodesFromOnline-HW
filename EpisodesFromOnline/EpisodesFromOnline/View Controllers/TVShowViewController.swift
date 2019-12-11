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
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadShows(for: searchQuery)
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
            DispatchQueue.main.async {
                self.loadShows(for: self.searchQuery)
            }
        }
    }
    
    

    func loadShows(for search: String) {        
        TVShowSearchAPI.fetchShows(for: search) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let shows):
                self?.showArr = shows
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
        return 250
    }
}

extension TVShowViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else {
            return
        }
        searchQuery = searchText
        loadShows(for: searchQuery)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchQuery = searchText
        TVShowSearchAPI.fetchShows(for: searchQuery) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let shows):
                self?.showArr = shows
            }
        }
    }
    
}
