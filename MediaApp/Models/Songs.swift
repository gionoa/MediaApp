//
//  Songs.swift
//  MediaApp
//
//  Created by Gio on 11/7/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation

struct Song: Identifiable {
    let id = UUID()
    let artistName: String
    let songName: String
    let imageUrl: String
}
