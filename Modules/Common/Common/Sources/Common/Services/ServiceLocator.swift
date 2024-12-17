//
//  File.swift
//  Common
//
//  Created by Bodgar Espinosa Miranda on 17/12/24.
//

import Foundation

enum ServiceRegistrationType<T> {
    case notInstantiated(() -> T)
    case instantiated(T)
}

/// Provides a registry of instances of types conforming to Service.
public final class ServiceLocator {
    
    // MARK: Private Properties
    
    private static var services = [String: ServiceRegistrationType<Any>]()
    
    // MARK: Public Methods
    
    /// Function that can help us to register each service, with a closure that it works to instantiate once we need.
    public static func register<T>(_ type: T.Type, factory: @autoclosure @escaping () -> T) {
        let key = "\(type)"
        services[key] = .notInstantiated(factory)
    }
    
    /// Function to get the service that we registered before.
    public static func get<T>(_ type: T.Type = T.self) -> T? {
        let key = "\(T.self)"
        
        switch services[key] {
        case .notInstantiated(let factory) :
            let instance = factory()
            services[key] = .instantiated(instance)
            return instance as? T
        case .instantiated(let instance as T) :
            return instance
        default:
            return nil
        }
    }
    
    public static func remove<T>(_ type: T.Type = T.self) {
        let key = "\(T.self)"
        services[key] = nil
    }
}
