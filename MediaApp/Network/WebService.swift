//
//  WebService.swift
//  MediaApp
//
//  Created by Gio on 11/7/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation
import Combine
import UIKit

enum NetworkError: Error, CustomStringConvertible {
    case fetching
    case url
    case decoding
    
    var description: String {
        switch self {
            case .fetching: return "Failed to fetch"
            case .url: return "Failed to build URL"
            case .decoding: return "Failed to decode"
        }
    }
}

enum WebService {
    private static func fetch(_ url: URL) -> AnyPublisher<Data, Error> {
        return
            URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard
                    let httpResponse = response as? HTTPURLResponse,
                        200..<300 ~= httpResponse.statusCode
                else {
                    throw NetworkError.fetching
                }
                return data
            }
            .eraseToAnyPublisher()
    }
    
    static func fetch<T: Decodable>(_ path: Path) -> AnyPublisher<T, NetworkError> {
        return
            fetch(path.url!)
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { _ in return NetworkError.decoding }
                .eraseToAnyPublisher()
    }
    
    static func fetchImage(urlString: String) -> AnyPublisher<UIImage, Error> {
        let url = URL(string: urlString)
        
        return
            URLSession.shared.dataTaskPublisher(for: url!)
                .tryMap { data, response in
                    guard let image = UIImage(data: data) else {
                        throw NetworkError.fetching
                    }
                    return image
                }
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
    }
}
