//
//  Bindable.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 16/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import Foundation

class Bindable<T> {
    typealias Listener = (T) -> Void
    
    // MARK: Properties
    
    /// Value Subscriber
    var listener: Listener?
    
    /// A Generic value which calls the subscriber/listener when any value gets assigned
    var value: T {
        didSet {
            self.listener?(self.value)
        }
    }
    
    // MARK: - Constructor
    /// Initialses the Binder with Generic Value
    /// - Parameters:
    ///    - value: A generic value
    init(_ value: T) {
        self.value = value
    }
    
    // MARK: - Bindable
    /// Binds the subscriber
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
