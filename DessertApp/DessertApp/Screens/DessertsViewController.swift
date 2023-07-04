//
//  DessertsViewController.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/3/23.
//

import UIKit

class DessertsViewController: UIViewController {
    
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
        showLoadingSpinner(on: view)
        viewModel.getDesserts()
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

    func setupBindings() {
        viewModel.desserts.bind(skipInitialListenerCall: true) { [weak self] _ in
            self?.dessertsTableView.reloadData()
            self?.removeLoadingSpinner()
        }
        viewModel.dessertDetail.bind(skipInitialListenerCall: true) { [weak self] dessertDetail in
            self?.removeLoadingSpinner()
            guard let dessertDetail = dessertDetail else { return }
            self?.navigationController?.pushViewController(DessertDetailViewController(dessertDetail: dessertDetail), animated: true)
        }
    }
}

extension DessertsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = viewModel.desserts.value?.list else { return 0 }
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let desserts = viewModel.desserts.value else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // TODO: refactor this into the viewmodel for the cell. Will probably have to make a custom cell
        viewModel.networkManager.getDessertThumbnailImage(from: URL(string: desserts.list[indexPath.row].thumbnailURL)!, completion: { image in
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showLoadingSpinner(on: view)
        viewModel.getDessertDetail(for: indexPath)
    }

}
