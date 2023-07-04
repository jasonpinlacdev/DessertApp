//
//  DessertDetailViewController.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/3/23.
//

import UIKit

class DessertDetailViewController: UIViewController {
    
    let dessertDetailTableView = UITableView()
    
    var dessertDetailID: String
    var networkManager = NetworkManager()
    var dessertDetail: DessertDetail?
    var ingredients: [IngredientModel] = []
    
    init(dessertDetailID: String) {
        self.dessertDetailID = dessertDetailID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        title = "Dessert Detail"
        view.backgroundColor = UIColor.systemBackground
        
        // show loading
        networkManager.getDessertDetail(from: URL(string: networkManager.dessertDetailURLString + dessertDetailID)!) { [weak self] dessertDetail in
            // dismiss loading
            guard let self = self else { return }
            self.dessertDetail = dessertDetail
        }
    }
    
    func setupTableView() {
        
    }
    
    // this method should go in the viewModel
    func processNumberOfActualIngredients() {
        
        guard let dessertDetail = dessertDetail else { return }
        // process how many ingredients there are
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
    }
    
    
}

extension DessertDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dessertDetail = dessertDetail else { return 0 }
        
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return dessertDetail.
        case 4:
            return
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
