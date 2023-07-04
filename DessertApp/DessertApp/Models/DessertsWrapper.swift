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

struct DessertDetailWrapper: Codable {
    let dessertDetailList: [DessertDetail]

    enum CodingKeys: String, CodingKey {
        case dessertDetailList = "meals"
    }
}

struct DessertDetail: Codable {
    var id: String
    var name: String
    var thumbnailURLString: String
    var instructions: String
    var ingredient1: String?
    var ingredient2: String?
    var ingredient3: String?
    var ingredient4: String?
    var ingredient5: String?
    var ingredient6: String?
    var ingredient7: String?
    var ingredient8: String?
    var ingredient9: String?
    var ingredient10: String?
    var ingredient11: String?
    var ingredient12: String?
    var ingredient13: String?
    var ingredient14: String?
    var ingredient15: String?
    var ingredient16: String?
    var ingredient17: String?
    var ingredient18: String?
    var ingredient19: String?
    var ingredient20: String?
    var measure1: String?
    var measure2: String?
    var measure3: String?
    var measure4: String?
    var measure5: String?
    var measure6: String?
    var measure7: String?
    var measure8: String?
    var measure9: String?
    var measure10: String?
    var measure11: String?
    var measure12: String?
    var measure13: String?
    var measure14: String?
    var measure15: String?
    var measure16: String?
    var measure17: String?
    var measure18: String?
    var measure19: String?
    var measure20: String?

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailURLString = "strMealThumb"
        case instructions = "strInstructions"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
        case measure16 = "strMeasure16"
        case measure17 = "strMeasure17"
        case measure18 = "strMeasure18"
        case measure19 = "strMeasure19"
        case measure20 = "strMeasure20"
    }
}


//struct Desserts: Codable {
//    let meals: [Meal]
//}
//
//struct Meal: Codable {
//    let strMeal: String
//    let strMealThumb: String
//    let idMeal: String
//}
//
//// we will need to make a separate call and decode for this DessertDetail
//struct MealDetailWrapper: Codable {
//    let meals: [MealDetail] // <-- we need to only access index 0
//}
//
//struct MealDetail: Codable {
//    var idMeal: String
//    var strMeal: String
//    var strInstructions: String
//    var strMealThumb: String
//    var strIngredient1: String
//    var strIngredient2: String
//    var strIngredient3: String
//    var strIngredient4: String
//    var strIngredient5: String
//    var strIngredient6: String
//    var strIngredient7: String
//    var strIngredient8: String
//    var strIngredient9: String
//    var strIngredient10: String
//    var strIngredient11: String
//    var strIngredient12: String
//    var strIngredient13: String
//    var strIngredient14: String
//    var strIngredient15: String
//    var strIngredient16: String
//    var strIngredient17: String
//    var strIngredient18: String
//    var strIngredient19: String
//    var strIngredient20: String
//    var strMeasure1: String
//    var strMeasure2: String
//    var strMeasure3: String
//    var strMeasure4: String
//    var strMeasure5: String
//    var strMeasure6: String
//    var strMeasure7: String
//    var strMeasure8: String
//    var strMeasure9: String
//    var strMeasure10: String
//    var strMeasure11: String
//    var strMeasure12: String
//    var strMeasure13: String
//    var strMeasure14: String
//    var strMeasure15: String
//    var strMeasure16: String
//    var strMeasure17: String
//    var strMeasure18: String
//    var strMeasure19: String
//    var strMeasure20: String
//}

