//
//  DessertTableViewCell.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/4/23.
//

import UIKit

class DessertsTableViewCell: UITableViewCell {
    
    private var imageRequest: Cancellable?
    private var placeHolderImage = UIImage(systemName: "questionmark")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // configure the cell with text and image
    func configure(dessertName: String, imageURL: URL, imageManager: ImageManager) {
        setContentConfig(text: dessertName, image: placeHolderImage)
        imageRequest = imageManager.getImage(for: imageURL) { [weak self] image in
            guard let self = self else { return }
            setContentConfig(text: dessertName, image: image)
        }
    }
    
    // reset the cell
    override func prepareForReuse() {
        super.prepareForReuse()
        print("Preparing cell for reuse")
        setContentConfig(text: nil, image: placeHolderImage)
        print("Canceling previous imageRequest dataTaks: \(String(describing: imageRequest))")
        imageRequest?.cancel()
    }
    
    // helper methods
    private func setContentConfig(text: String?, image: UIImage?) {
        var contentConfig = self.defaultContentConfiguration()
        contentConfig.text = text
        contentConfig.image = image
        contentConfig.imageProperties.maximumSize = CGSize(width: 75, height: 75)
        contentConfig.imageProperties.cornerRadius = 3
        self.contentConfiguration = contentConfig
    }
}