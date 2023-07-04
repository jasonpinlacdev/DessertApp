//
//  DessertDetailViewModel.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/4/23.
//

import Foundation

class DessertDetailViewModel {
    var imageManager: ImageManager
    var networkManager = NetworkManager()
    var dessertDetail: DessertDetail
    var actualIngredients: [IngredientModel] = []

    init(dessertDetail: DessertDetail, imageManager: ImageManager) {
        self.dessertDetail = dessertDetail
        self.imageManager = imageManager
        processNumberOfActualIngredients()
    }
    
    var dessertDetailName: String {
        return dessertDetail.name
    }
    
    var dessertDetailInstructions: String {
        return dessertDetail.instructions
    }
    
    var dessertDetailThumbnailURLString: String {
        return dessertDetail.thumbnailURLString
    }
    
    func processNumberOfActualIngredients() {
        var ingredients: [IngredientModel] = []
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient1, measure: dessertDetail.measure1))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient2, measure: dessertDetail.measure2))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient3, measure: dessertDetail.measure3))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient4, measure: dessertDetail.measure4))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient5, measure: dessertDetail.measure5))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient6, measure: dessertDetail.measure6))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient7, measure: dessertDetail.measure7))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient8, measure: dessertDetail.measure8))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient9, measure: dessertDetail.measure9))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient10, measure: dessertDetail.measure10))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient11, measure: dessertDetail.measure11))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient12, measure: dessertDetail.measure12))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient13, measure: dessertDetail.measure13))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient14, measure: dessertDetail.measure14))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient15, measure: dessertDetail.measure15))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient16, measure: dessertDetail.measure16))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient17, measure: dessertDetail.measure17))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient18, measure: dessertDetail.measure18))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient19, measure: dessertDetail.measure19))
        ingredients.append(IngredientModel(ingredientName: dessertDetail.ingredient20, measure: dessertDetail.measure20))
        ingredients.forEach { ingredientModel in
            if let ingredientName = ingredientModel.ingredientName {
                if !ingredientName.isEmpty {
                    actualIngredients.append(ingredientModel)
                }
            }
        }
    }
}
