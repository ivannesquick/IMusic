//
//  SearchResponse.swift
//  IMusic
//
//  Created by Neskin Ivan on 25.03.2020.
//  Copyright © 2020 Neskin Ivan. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount:Int
    var results:[Track]
}

struct Track: Decodable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var atworkURL100: String?
    var previewUrl: String?
}
