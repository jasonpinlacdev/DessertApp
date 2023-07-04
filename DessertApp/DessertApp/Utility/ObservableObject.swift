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
    
    func bind(skipInitialListenerCall: Bool = false, listener: @escaping (T) -> Void) {
        self.listeners.append(listener)
        guard !skipInitialListenerCall else { return }
        listener(value)
    }
    
}
