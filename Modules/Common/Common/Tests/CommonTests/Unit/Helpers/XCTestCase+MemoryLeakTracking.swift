//
//  XCTestCase+MemoryLeakTracking.swift
//
//
//  Created by Bodgar Espinosa Miranda on 07/08/24.
//

import Foundation
import XCTest

public extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance,
                         "Instance should have been deallocatyed. Potential memory leak.",
                         file: file,
                         line: line)
        }
    }
}
