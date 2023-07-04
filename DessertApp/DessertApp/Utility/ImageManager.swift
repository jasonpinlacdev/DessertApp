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
    
    func getImage(for url: URL, completion: @escaping (Result<UIImage, NetworkManager.HTTPError>) -> Void) -> Cancellable? {
        
        // Check cache for image data based off of URL
        if let image = getCachedImage(for: url) {
            DispatchQueue.main.async {
                completion(.success(image))
            }
            print("no need to create run a DataTask. Returning nil")
            return nil
        }
        
        print("making request to download image at \(url)")
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            // check the error
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.networkError))
                }
                return
            }
            // check the response
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(.failedResponse))
                }
                return
            }
            // check the data
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidData))
                }
                return
            }
            self?.cacheImage(data, for: url)
            // create the image from data
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.failedDecoding))
                }
                return
            }
        }
        dataTask.resume()
        return dataTask
    }
    
    private func cacheImage(_ data: Data, for url: URL) {
        print("caching Image...")
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
