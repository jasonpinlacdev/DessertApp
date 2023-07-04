//
//  Desserts.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/3/23.
//

import Foundation

struct DessertsWrapper: Codable {
    let dessertsList: [Dessert]
    
    enum CodingKeys: String, CodingKey {
        case dessertsList = "meals"
    }
}

struct Dessert: Codable {
    let name: String
    let thumbnailURL: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumbnailURL = "strMealThumb"
        case id = "idMeal"
    }
}






