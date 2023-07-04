//
//  NetworkManager.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/3/23.
//

import UIKit



final class NetworkManager {
    
    enum HTTPError: Error {
        case networkError
        case failedResponse
        case invalidData
        case failedDecoding
    }

    let dessertsURLString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    let dessertDetailURLString = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    // TODO: - refactor network layer to use generics
    
    
    func request<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkManager.HTTPError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            // 1 check the error
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
            
            // 2 check the response
            guard let urlResponse = urlResponse as? HTTPURLResponse, (200...299).contains(urlResponse.statusCode) else {
                completion(.failure(.failedResponse))
                return
            }
            // 3 check the data
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            // 4 Decode the data
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.failedDecoding))
            }
        }.resume()
    }
    
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
    
    
    
    
    
    
//    func getDesserts(from url: URL, completion: @escaping (Desserts) -> Void) {
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            // check the error
//            guard error == nil else {
//                print("network error")
//                return
//            }
//
//            // check the response
//            guard let response = response as? HTTPURLResponse,
//                  (200...299).contains(response.statusCode) else {
//                print("network httpURLResponse error")
//                return
//            }
//
//            // check the data
//            guard let data = data else {
//                print("network data error")
//                return
//            }
//
//            // decode the data
//            do {
//                let desserts = try JSONDecoder().decode(Desserts.self, from: data)
//                DispatchQueue.main.async {
//                    completion(desserts)
//                }
//            } catch {
//                print(error)
//                print("decode error at desserts")
//            }
//        }.resume()
//    }
//
//    func getDessertDetail(from url: URL, completion: @escaping (DessertDetail)-> Void) {
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            // check the error
//            guard error == nil else {
//                print("network error")
//                return
//            }
//
//            // check the response
//            guard let response = response as? HTTPURLResponse,
//                  (200...299).contains(response.statusCode) else {
//                print("network httpURLResponse error")
//                return
//            }
//
//            // check the data
//            guard let data = data else {
//                print("network data error")
//                return
//            }
//
//            // decode the data
//            do {
//                let dessertDetailWrapper = try JSONDecoder().decode(DessertDetailWrapper.self, from: data)
//                DispatchQueue.main.async {
//                    completion(dessertDetailWrapper.list[0])
//                }
//            } catch {
//                print(error)
//                print("decode error at dessert detail")
//            }
//        }.resume()
//    }
}
