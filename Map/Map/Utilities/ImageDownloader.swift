//
//  ImageDownloader.swift
//  Map
//
//  Created by Marcin on 17.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation
import Haneke

typealias ImageDownloaded = (_ image: UIImage?) -> Void

final class ImageDownloader {
    
    static func getImage(_ url: URL, completion: @escaping ImageDownloaded) {
        let cache = Shared.imageCache
        let fetcher = NetworkFetcher<UIImage>(URL: url)
        cache.fetch(fetcher: fetcher).onSuccess { image in
            completion(image)
            }.onFailure { (error) in
                completion(nil)
        }
    }
}
