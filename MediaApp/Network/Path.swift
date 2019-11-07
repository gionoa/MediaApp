//
//  Path.swift
//  MediaApp
//
//  Created by Gio on 11/7/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation

enum Path: String {
    case songs
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rss.itunes.apple.com"
        
        switch self {
        case .songs:
            components.path = "/api/v1/us/apple-music/top-songs/all/50/explicit.json"
        }
        return components.url
    }
}
