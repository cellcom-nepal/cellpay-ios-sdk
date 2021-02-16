//
//  RedirectHandler.swift
//  CellPaySDK
//
//  Created by CellPay on 2/12/21.
//  Copyright © 2021 CellPay. All rights reserved.
//

import Foundation
public protocol RedirectHandler {
    /// Determines how the HTTP redirect response should be redirected to the new request.
    ///
    /// The `completion` closure should be passed one of three possible options:
    ///
    ///   1. The new request specified by the redirect (this is the most common use case).
    ///   2. A modified version of the new request (you may want to route it somewhere else).
    ///   3. A `nil` value to deny the redirect request and return the body of the redirect response.
    ///
    /// - Parameters:
    ///   - task:       The `URLSessionTask` whose request resulted in a redirect.
    ///   - request:    The `URLRequest` to the new location specified by the redirect response.
    ///   - response:   The `HTTPURLResponse` containing the server's response to the original request.
    ///   - completion: The closure to execute containing the new `URLRequest`, a modified `URLRequest`, or `nil`.
    func task(_ task: URLSessionTask,
              willBeRedirectedTo request: URLRequest,
              for response: HTTPURLResponse,
              completion: @escaping (URLRequest?) -> Void)
}
