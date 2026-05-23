//
//  ImageCache.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import UIKit

final class ImageCache: @unchecked Sendable {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()

    private init() {
        cache.countLimit = 100
        cache.totalCostLimit = 50 * 1024 * 1024
    }

    func image(for url: URL) -> UIImage? {
        cache.object(forKey: url.absoluteString as NSString)
    }

    func store(_ image: UIImage, for url: URL) {
        let cost = Int(image.size.width * image.size.height * 4)  // approx bytes
        cache.setObject(image, forKey: url.absoluteString as NSString, cost: cost)
    }
}
