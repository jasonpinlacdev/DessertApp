//
//  UIViewController+Spinner.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/3/23.
//

import UIKit


var loadingSpinnerView: UIView?

extension UIViewController {
    func showLoadingSpinner(on view: UIView) {
        let spinnerView = UIView(frame: view.bounds)
        spinnerView.backgroundColor = UIColor(white: 0.2, alpha: 0.2)
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.startAnimating()
        activityIndicatorView.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicatorView)
            view.addSubview(spinnerView)
        }
        
        loadingSpinnerView = spinnerView
    }
    
    func removeLoadingSpinner() {
        DispatchQueue.main.async {
            loadingSpinnerView?.removeFromSuperview()
            loadingSpinnerView = nil
        }
    }
}
