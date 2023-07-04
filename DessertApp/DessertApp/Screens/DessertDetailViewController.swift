//
//  DessertDetailViewController.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/3/23.
//

import UIKit

class DessertDetailViewController: UIViewController {
    
    let dessertDetailTableView = UITableView()
    
    var dessertDetail: DessertDetail
    var networkManager = NetworkManager()
    var actualIngredients: [IngredientModel] = []
    
    init(dessertDetail: DessertDetail) {
        self.dessertDetail = dessertDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
    }
    
    func setup() {
        navigationItem.largeTitleDisplayMode = .never
        title = dessertDetail.name
        view.backgroundColor = UIColor.systemBackground
        processNumberOfActualIngredients()
    }
    
    func setupTableView() {
        dessertDetailTableView.dataSource = self
        dessertDetailTableView.delegate = self
        dessertDetailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        dessertDetailTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dessertDetailTableView)
        NSLayoutConstraint.activate([
            dessertDetailTableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dessertDetailTableView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            dessertDetailTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
            dessertDetailTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0),
        ])
    }
    
    // TODO: - this method should go in the viewModel
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

extension DessertDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: // thumbnail
            return 1
        case 1: // instructions
            return 1
        case 2: // ingredients
            return actualIngredients.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // image
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            // TODO: - This needs to be refactored to ge the image out of the cache instead of redownloading it
            networkManager.getDessertThumbnailImage(from: URL(string: dessertDetail.thumbnailURLString)!, completion: { [weak self] image in
                guard let self = self else { return }
                var contentConfig = cell.defaultContentConfiguration()
                print(image)
                contentConfig.image = image
                contentConfig.imageProperties.maximumSize = CGSize(width: self.view.frame.width, height: self.view.frame.width)
                contentConfig.imageProperties.cornerRadius = 3
                cell.contentConfiguration = contentConfig
            })
            var contentConfig = cell.defaultContentConfiguration()
            cell.contentConfiguration = contentConfig
            cell.selectionStyle = .none
            return cell
        case 1: // instructions
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = dessertDetail.instructions
            cell.contentConfiguration = contentConfig
            cell.selectionStyle = .none
            return cell
        case 2: // ingredients
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = "\(actualIngredients[indexPath.row].ingredientName ?? "Unknown Ingredient") : \(actualIngredients[indexPath.row].measure ?? "Unknown Measure")"
            cell.contentConfiguration = contentConfig
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "Instructions"
        case 2:
            return "Ingredients"
        default:
            return nil
        }
    }
    
}
