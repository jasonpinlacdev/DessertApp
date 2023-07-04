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
    
    func getDesserts(completion: @escaping (Result<DessertsWrapper, NetworkManager.HTTPError>) -> Void) {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        request(request: urlRequest) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func getDessertDetail(for id: String, completion: @escaping (Result<DessertDetailWrapper, NetworkManager.HTTPError>) -> Void) {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        request(request: urlRequest) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
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
}
