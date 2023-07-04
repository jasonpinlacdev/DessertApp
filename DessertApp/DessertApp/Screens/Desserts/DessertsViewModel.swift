//
//  DessertsViewModel.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/4/23.
//

import Foundation

class DessertsViewModel {
    let networkManager = NetworkManager()
    var imageManager = ImageManager()
    
    var desserts: ObservableObject<Desserts?> = ObservableObject(value: nil)
    var dessertDetail: ObservableObject<DessertDetail?> = ObservableObject(value: nil)
    var dessertsViewTitle = "Desserts"
    
    func getDesserts() {
        networkManager.getDesserts(from: URL(string: networkManager.dessertsURLString)!) { [weak self] desserts in
            self?.desserts.value = desserts
        }
    }
    
    func getDessertDetail(for indexPath: IndexPath) {
        guard let desserts = desserts.value else { return }
        networkManager.getDessertDetail(from: URL(string: networkManager.dessertDetailURLString + desserts.list[indexPath.row].id)!) { [weak self] dessertDetail in
            self?.dessertDetail.value = dessertDetail
        }
    }
}
