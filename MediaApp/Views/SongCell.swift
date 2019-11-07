//
//  SongCell.swift
//  MediaApp
//
//  Created by Gio on 11/7/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation
import SwiftUI

struct SongCell: View {
    @ObservedObject var imageLoader = ImageLoader()
    
    let song: Song
    
    init(with song: Song) {
        self.song = song
    }
    
    var body: some View {
        HStack {
            Image(uiImage: imageLoader.image ?? UIImage(systemName: "waveform.path.ecg") as! UIImage)
                .resizable()
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(song.songName)
                    .fontWeight(.bold)
                Text(song.artistName)
            }
        }
        .onAppear {
            self.imageLoader.getImage(urlString: self.song.imageUrl)
        }
    }
}
