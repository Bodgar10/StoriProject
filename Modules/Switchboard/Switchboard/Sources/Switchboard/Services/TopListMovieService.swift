//
//  File.swift
//  Switchboard
//
//  Created by Bodgar Espinosa Miranda on 18/12/24.
//

import Foundation
import Combine
import Common

/// Service to get the information of the user.
public protocol TopListMovieService: Service {
    var userInfoPublisher: AnyPublisher<Result<UserInformation?, Error>, Error> { get }
    func refresh()
}
