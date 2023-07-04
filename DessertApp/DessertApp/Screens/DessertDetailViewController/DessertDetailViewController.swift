//
//  DessertDetailViewController.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/3/23.
//

import UIKit

class DessertDetailViewController: UIViewController {
    
    let dessertDetailTableView = UITableView()
    let viewModel: DessertDetailViewModel
    
    init(with viewModel: DessertDetailViewModel) {
        self.viewModel = viewModel
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
        title = viewModel.dessertDetailName
        view.backgroundColor = UIColor.systemBackground
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
}

extension DessertDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: // thumbnail image
            return 1
        case 1: // instructions
            return 1
        case 2: // ingredients
            return viewModel.actualIngredients.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // thumbnail image
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            // TODO: - This needs to be refactored to ge the image out of the cache instead of redownloading it
            viewModel.networkManager.getDessertThumbnailImage(from: URL(string: viewModel.dessertDetailThumbnailURL)!, completion: { [weak self] image in
                guard let self = self else { return }
                var contentConfig = cell.defaultContentConfiguration()
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
            contentConfig.text = viewModel.dessertDetailInstructions
            cell.contentConfiguration = contentConfig
            cell.selectionStyle = .none
            return cell
        case 2: // ingredients
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = "\(viewModel.actualIngredients[indexPath.row].ingredientName ?? "Unknown Ingredient") : \(viewModel.actualIngredients[indexPath.row].measure ?? "Unknown Measure")"
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
        case 0: // thumbnail image
            return nil
        case 1: // instructions
            return "Instructions"
        case 2: // ingredients
            return "Ingredients"
        default:
            return nil
        }
    }
}
