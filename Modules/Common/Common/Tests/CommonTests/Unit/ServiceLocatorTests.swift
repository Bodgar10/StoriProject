//
//  ServiceLocatorTests.swift
//  Common
//
//  Created by Bodgar Espinosa Miranda on 17/12/24.
//

import XCTest
import SwiftUI

@testable import Common

final class ServiceLocatorTests: XCTestCase {
    
    func test_getService_withServiceRegistered_returnServiceInstance() {
        // GIVEN
        ServiceLocator.register(ExampleProtocol.self, factory:
            ExampleService()
        )
        
        // WHEN
        @Dependency var service: ExampleProtocol
        
        // THEN
        XCTAssertEqual(service.greetings(), "Hello world")
    }
    
    func test_getService_withServiceRegistered_returnSameServiceInstanceEachTime() {
        
        // GIVEN
        ServiceLocator.register(ExampleProtocol.self, factory:
            ExampleService()
        )
        
        // WHEN
        @Dependency var serviceOne: ExampleProtocol
        @Dependency var serviceTwo: ExampleProtocol
        
        // THEN
        XCTAssertEqual(serviceOne.id, serviceTwo.id)
        XCTAssert(serviceOne === serviceTwo)
    }
    
    func test_getServiceOptional_withServiceRegistered_returnSameServiceInstanceEachTime() {
        
        // GIVEN
        ServiceLocator.register(ExampleProtocol.self, factory:
            ExampleService()
        )
        
        // WHEN
        @Dependency var serviceOne: ExampleProtocol
        @Dependency var serviceTwo: ExampleProtocol
        @Dependency var serviceThree: ExampleProtocol
        
        // THEN
        XCTAssertNotNil(serviceOne)
        XCTAssertNotNil(serviceTwo)
        XCTAssertNotNil(serviceThree)
        XCTAssertEqual(serviceOne.id, serviceTwo.id)
        XCTAssert(serviceOne === serviceTwo)
    }
    
    func test_getService_withTwoServicesRegistered_returnInstanceOfEachService() {
        
        // GIVEN
        // GIVEN
        ServiceLocator.register(ExampleProtocol.self, factory:
            ExampleService()
        )
        
        ServiceLocator.register(ColorProtocol.self, factory:
            ColorService()
        )
        
        // WHEN
        @Dependency var serviceOne: ExampleProtocol
        @Dependency var serviceTwo: ColorProtocol
        
        // THEN
        XCTAssertNotNil(serviceOne)
        XCTAssertNotNil(serviceTwo)
        XCTAssertEqual(serviceOne.greetings(), "Hello world")
        XCTAssertEqual(serviceTwo.getColor(), .red)
    }
    
}


// MARK: ExampleService

protocol ExampleProtocol: Service {
    func greetings() -> String
}

private final class ExampleService: ExampleProtocol {
    var id = UUID()
    
    func greetings() -> String {
        return "Hello world"
    }
}

// MARK: ColorService

protocol ColorProtocol: Service {
    func getColor() -> Color
}

private final class ColorService: ColorProtocol {
    var id = UUID()
    
    func getColor() -> Color {
        return .red
    }
}
