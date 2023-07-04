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
    
    var dessertsList: ObservableObject<[Dessert]?> = ObservableObject(value: nil)
    var dessertDetail: ObservableObject<DessertDetail?> = ObservableObject(value: nil)
    var networkManagerError: ObservableObject<NetworkManager.HTTPError?> = ObservableObject(value: nil)
    
    var dessertsViewTitle = "Desserts"
    
    func getDesserts() {
        networkManager.getDesserts() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dessertsWrapper):
                self.dessertsList.value = dessertsWrapper.dessertsList
            case .failure(let networkManagerError):
                self.networkManagerError.value = networkManagerError
            }
        }
    }
    
    func getDessertDetail(for indexPath: IndexPath) {
        guard let dessertsList = self.dessertsList.value else { return }
        networkManager.getDessertDetail(for: dessertsList[indexPath.row].id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dessertDetailWrapper):
                dessertDetail.value = dessertDetailWrapper.dessertDetailList[0]
            case .failure(let networkManagerError):
                self.networkManagerError.value = networkManagerError
            }
        }
    }
}
