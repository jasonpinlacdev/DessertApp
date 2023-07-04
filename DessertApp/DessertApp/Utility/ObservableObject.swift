//
//  ObservableObject.swift
//  DessertApp
//
//  Created by Jason Pinlac on 7/3/23.
//

import Foundation

final class ObservableObject<T> {
    
    var value: T {
        didSet {
            listeners.forEach { listener in
                listener(value)
            }
        }
    }
    
    private var listeners: [((T) -> Void)] = []
    
    init(value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping (T) -> Void) {
        self.listeners.append(listener)
        listener(value)
    }
    
}
