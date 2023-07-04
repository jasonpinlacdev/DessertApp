//
//  NetworkManager.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/3/23.
//

import UIKit

class NetworkManager {

    let dessertsURLString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    let dessertDetailURLString = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    // TODO: - refactor network layer to use generics
    // TODO: - let the thumbnailImage call go into an image manager class
    
    
    // This is not the best solution. We want to use generics
    func getDesserts(from url: URL, completion: @escaping (Desserts) -> Void) {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
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
            
            // decode the data
            do {
                let desserts = try JSONDecoder().decode(Desserts.self, from: data)
                DispatchQueue.main.async {
                    completion(desserts)
                }
            } catch {
                print(error)
                print("decode error at desserts")
            }
        }.resume()
    }
    
    func getDessertDetail(from url: URL, completion: @escaping (DessertDetail)-> Void) {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
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
            
            // decode the data
            do {
                let dessertDetailWrapper = try JSONDecoder().decode(DessertDetailWrapper.self, from: data)
                DispatchQueue.main.async {
                    completion(dessertDetailWrapper.list[0])
                }
            } catch {
                print(error)
                print("decode error at dessert detail")
            }
        }.resume()
    }
    
    func getDessertThumbnailImage(from url: URL, completion: @escaping (UIImage)-> Void) {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
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
            
            // decode the image
            if let thumbnailImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(thumbnailImage)
                }
            }
        }.resume()
        
        
    }
    
}
