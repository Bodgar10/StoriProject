//
//  Service.swift
//  Common
//
//  Created by Bodgar Espinosa Miranda on 17/12/24.
//

import Foundation

/// A service is an interface to part of the domain
public protocol Service: AnyObject {
    /// A unique way to identity a service instance
    var id: UUID { get }
}

///Property Wrapper to access the ServiceLocator.get and resolve dependecies.
@propertyWrapper
public struct Dependency<Service> {
    
    public var service: Service
    
    public init() {
        guard let service = ServiceLocator.get(Service.self) else {
            fatalError("No dependency of type \(String(describing: Service.self)) registered!")
        }
        self.service = service
    }
    
    public var wrappedValue: Service {
        get { self.service }
        mutating set { service = newValue }
    }
}
