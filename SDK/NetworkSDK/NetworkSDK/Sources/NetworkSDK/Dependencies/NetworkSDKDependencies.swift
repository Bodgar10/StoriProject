//
//  NetworkSDKDependencies.swift
//  NetworkSDK
//
//  Created by Bodgar Espinosa Miranda on 18/12/24.
//

import Foundation
import Switchboard
import Common

public struct NetworkSDKDependencies {
    public init() {
        registerDependencies()
    }
    
    private func registerDependencies() {
        ServiceLocator.register(TopListMovieService.self, factory: TopListMoviesAPIService())
    }
}
