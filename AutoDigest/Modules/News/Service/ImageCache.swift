//
//  ImageCache.swift
//  AutoDigest
//
//  Created by Антон Павлов on 18.07.2025.
//

import UIKit

// MARK: - ImageCache

final class ImageCache {
    
    // MARK: - Singleton
    
    static let shared = ImageCache()
    
    // MARK: - Private Properties
    
    private let cache = NSCache<NSString, UIImage>()
    
    // MARK: - Public Methods
    
    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url.absoluteString as NSString)
    }
    
    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return }
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }
    
    // MARK: - Initializers
    
    private init() {}
}
