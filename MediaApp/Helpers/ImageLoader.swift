//
//  ImageLoader.swift
//  MediaApp
//
//  Created by Gio on 11/7/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage!
    
    func getImage(urlString: String) {
        WebService.fetchImage(urlString: urlString)
            .sink(receiveCompletion: { completion in }) { image in
                self.image = image
            }
        }
}
