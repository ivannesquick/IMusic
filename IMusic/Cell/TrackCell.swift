//
//  TrackCell.swift
//  IMusic
//
//  Created by Neskin Ivan on 28.03.2020.
//  Copyright © 2020 Neskin Ivan. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {
    
    static let reuseID = "TrackCell"
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWith(item: Track) {
        trackNameLabel.text = item.trackName
        artistNameLabel.text = item.artistName
        collectionNameLabel.text = item.collectionName
    }
}
