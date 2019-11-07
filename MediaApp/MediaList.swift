//
//  ContentView.swift
//  MediaApp
//
//  Created by Gio on 11/7/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import SwiftUI

struct SongList: View {
    @ObservedObject var viewModel = SongsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.songs) { song in
                SongCell(with: song)
            }
        .navigationBarTitle("Top Songs")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SongList()
    }
}
