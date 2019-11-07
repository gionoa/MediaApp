//
//  MediaViewModel.swift
//  MediaApp
//
//  Created by Gio on 11/7/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation
import SwiftUI

class SongsViewModel: ObservableObject {
    @Published var songs = [Song]()
    
    init() {
        fetchMediaItems()
    }
    
    private func fetchMediaItems() {
        struct Results: Codable {
            let feed: Feed
            
            enum CodingKeys: String, CodingKey {
                case feed = "feed"
            }
        }
        
        struct Feed: Codable {
            let results: [Result]
            
            enum CodingKeys: String, CodingKey {
                case results = "results"
            }
        }
        
        struct Result: Codable {
            let artistName: String
            let songName: String
            let artworkUrl100: String
            
            enum CodingKeys: String, CodingKey {
                case artistName = "artistName"
                case songName = "name"
                case artworkUrl100 = "artworkUrl100"
            }
        }
        
        WebService.fetch(.songs)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { (results: Results) in
                self.songs = results.feed.results.map { song in
                    Song(artistName: song.artistName, songName: song.songName, imageUrl: song.artworkUrl100) }
            })
    }
}

