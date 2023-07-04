//
//  DessertDetailImageTableViewCell.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/4/23.
//

import UIKit

class DessertDetailImageTableViewCell: UITableViewCell {
    
    private var imageRequest: Cancellable?
    private var placeholderImage = UIImage(systemName: "questionmark")
    private var imageSize: CGFloat = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // configure cell with image from cache
    func configure(imageURL: URL, imageManager: ImageManager, size: CGFloat) {
        if imageSize == 0 {
            imageSize = size // set the image size once for the cell
        }
        setContentConfig(image: placeholderImage, size: size)
        imageRequest = imageManager.getImage(for: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                self?.setContentConfig(image: image, size: size)
            case .failure(let networkManagerError):
                print("Something went wrong with Image Manager Request: \(networkManagerError)")
            }
         
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageRequest?.cancel()
        print("preparing for reuse")
        setContentConfig(image: placeholderImage, size: imageSize)
    }
    
    // helper methods
    private func setContentConfig(image: UIImage?, size: CGFloat) {
        var contentConfig = self.defaultContentConfiguration()
        contentConfig.image = image
        contentConfig.imageProperties.maximumSize = CGSize(width: size, height: size)
        contentConfig.imageProperties.cornerRadius = 3
        self.contentConfiguration = contentConfig
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
