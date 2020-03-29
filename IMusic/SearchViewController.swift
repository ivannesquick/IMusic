//
//  SearchViewController.swift
//  IMusic
//
//  Created by Neskin Ivan on 24.03.2020.
//  Copyright © 2020 Neskin Ivan. All rights reserved.
//

import UIKit


class SearchViewController: UITableViewController {
    
    private var networkService = NetworkService()
    private var timer: Timer?
    private var searchController = UISearchController(searchResultsController: nil)
    var tracks = [Track]()
    private lazy var footerView = FooterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupSearchBar()
    }
    func setupTableView() {
       tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        let nib  = UINib(nibName: "TrackCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TrackCell.reuseID)
        tableView.tableFooterView = UIView()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.reuseID, for: indexPath) as! TrackCell
        let track = tracks[indexPath.row]
        cell.trackImageView.backgroundColor = .red
        cell.configureWith(item: track)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let labelHeader = UILabel()
        labelHeader.text = "Enter search track"
        labelHeader.textAlignment = .center
        labelHeader.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return labelHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tracks.count > 0 ? 0 : 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = tracks[indexPath.row]
        print(track.artistName)
        let window = UIApplication.shared.keyWindow
        let trackDetailView = Bundle.main.loadNibNamed("TrackDetailView", owner: self, options: nil)?.first as! TrackDetailView
        trackDetailView.configureWith(item: track)
        window?.addSubview(trackDetailView)
    }
}

extension SearchViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
             let url = "https://itunes.apple.com/search?term=\(searchText)"
             self.networkService.downloadData(url: url) { [weak self] (searchResult) in
                self?.tracks = searchResult.results ?? []
                self!.tableView.reloadData()
                   }
        })
    }
}
