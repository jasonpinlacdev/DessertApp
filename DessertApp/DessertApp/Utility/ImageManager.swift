//
//  ImageManager.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/4/23.
//

import UIKit

protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable {}

final class ImageManager {
    
    private struct CachedImage {
        let url: URL
        let data: Data
    }
    
    private var cache: [CachedImage] = []
    
    func getImage(for url: URL, completion: @escaping (UIImage) -> Void) -> Cancellable? {
        
        // Check cache for image data based off of URL
        if let image = getCachedImage(for: url) {
            completion(image)
            print("No need to create run a DataTask. Returning nil")
            return nil
        }
        
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            // check the error
            guard error == nil else {
                print("network error")
                return
            }
            
            // check the response
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                print("network httpURLResponse error")
                return
            }
            
            // check the data
            guard let data = data else {
                print("network data error")
                return
            }
            self?.cacheImage(data, for: url)
            
            
            // decode the image data
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                print("failed to create UIImage from data")
                return
            }
        }
        dataTask.resume()
        return dataTask
    }
    
    private func cacheImage(_ data: Data, for url: URL) {
        let cachedImage = CachedImage(url: url, data: data)
        cache.append(cachedImage)
    }
    
    private func getCachedImage(for url: URL) -> UIImage? {
        guard let data = cache.first(where: { $0.url == url })?.data else {
            print("there isnt a cached image for url: \(url)")
            return nil
        }
        print("found a cached image: \(data) from url: \(url)")
        return UIImage(data: data)
    }
}
