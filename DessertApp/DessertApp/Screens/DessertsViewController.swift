//
//  DessertsViewController.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/3/23.
//

import UIKit

class DessertsViewModel {
    let networkManager = NetworkManager()
    var desserts: ObservableObject<Desserts?> = ObservableObject(value: nil)
    
    var dessertsViewTitle = "Desserts"
}


class DessertsViewController: UIViewController {
    
//    let networkManager = NetworkManager() // <--- this should go in a viewModel
//    var desserts: Desserts?
    
    let viewModel = DessertsViewModel()
    
    let dessertsTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        title = viewModel.dessertsViewTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.systemBackground
        setupTableView()
        setupBindings()
        getDesserts()
    }
    
    func setupTableView() {
        dessertsTableView.dataSource = self
        dessertsTableView.delegate = self
        dessertsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        dessertsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dessertsTableView)
        NSLayoutConstraint.activate([
            dessertsTableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dessertsTableView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            dessertsTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
            dessertsTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0),
        ])
    }
    
    // this functionality should go in the viewModel
    func getDesserts() {
        showLoadingSpinner(on: view)
        networkManager.getDesserts(from: URL(string: networkManager.dessertsURLString)!) { [weak self] desserts in
            self?.removeLoadingSpinner()
            self?.desserts = desserts
            self?.dessertsTableView.reloadData()
        }
    }
    
    func setupBindings() {
        viewModel.desserts.bind { [weak self] _ in
            self?.dessertsTableView.reloadData()
        }
    }
    
}

extension DessertsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let desserts = desserts else { return 0 }
        return desserts.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let desserts = desserts else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       
        // TODO: refactor this into the viewmodel
        networkManager.getDessertThumbnailImage(from: URL(string: desserts.list[indexPath.row].thumbnailURL)!, completion: { image in
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = desserts.list[indexPath.row].name
            contentConfig.image = image
            contentConfig.imageProperties.maximumSize = CGSize(width: 75, height: 75)
            contentConfig.imageProperties.cornerRadius = 3
            cell.contentConfiguration = contentConfig
        })

        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = desserts.list[indexPath.row].name
        contentConfig.image = UIImage(systemName: "questionmark")
        contentConfig.imageProperties.maximumSize = CGSize(width: 75, height: 75)
        contentConfig.imageProperties.cornerRadius = 3
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = contentConfig
        
//        cell.textLabel?.text = desserts.list[indexPath.row].name
//        networkManager.getDessertThumbnailImage(from: URL(string: desserts.list[indexPath.row].thumbnailURL)!, completion: { image in
//            cell.imageView?.image = image
//        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let desserts = desserts else { return }
        
        showLoadingSpinner(on: view)
        networkManager.getDessertDetail(from: URL(string: networkManager.dessertDetailURLString + desserts.list[indexPath.row].id)!) { [weak self] dessertDetail in
            self?.removeLoadingSpinner()
            self?.navigationController?.pushViewController(DessertDetailViewController(dessertDetail: dessertDetail), animated: true)
        }
        
    }

}
