//
//  DessertsViewController.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/3/23.
//

import UIKit

/* TODO: - Todo List
 Done - refactor screens into mvvm using observableObject for binding listeniners
 Done - create an image manager that downloads and caches downloaded images
 Done - create custom tableViewCells classes that encapsulate the logic to download images using the image manager and set them
 Done - cancel the current datatask if scrolling the tableview
 refactor network layer to use generics
 create splash page
 unit tests
 */

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
        dessertsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        dessertsTableView.register(DessertsTableViewCell.self, forCellReuseIdentifier: "DessertsTableViewCell")
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
            guard let self = self else { return }
            self.removeLoadingSpinner()
            guard let dessertDetail = dessertDetail else { return }
            let dessertDetailViewModel = DessertDetailViewModel(dessertDetail: dessertDetail, imageManager: self.viewModel.imageManager)
            let dessertDetailViewController = DessertDetailViewController(with: dessertDetailViewModel)
            self.navigationController?.pushViewController(dessertDetailViewController, animated: true)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DessertsTableViewCell", for: indexPath) as? DessertsTableViewCell else {
            print("Failed to dequeue DessertsTableViewCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            return cell
        }
        
        cell.configure(dessertName: desserts.list[indexPath.row].name, imageURL: URL(string: desserts.list[indexPath.row].thumbnailURL)!, imageManager: viewModel.imageManager)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showLoadingSpinner(on: view)
        viewModel.getDessertDetail(for: indexPath)
    }
    
}
