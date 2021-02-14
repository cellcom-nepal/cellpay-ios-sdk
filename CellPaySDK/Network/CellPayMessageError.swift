//
//  CellPayMessageError.swift
//  CellPaySDK
//
//  Created by esewa on 2/12/21.
//  Copyright © 2021 esewa. All rights reserved.
//

import Foundation
struct CellPayMessageError: Codable {
    let status, sessionExpired: Bool
    let errors: [CellPayError]

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case sessionExpired = "sessionExpired"
        case errors = "errors"
       
    }
}

// MARK: - Error
struct CellPayError: Codable {
    let shortMessage, longMessage: String
    enum CodingKeys: String, CodingKey {
        case shortMessage = "shortMessage"
        case longMessage = "longMessage"
       
    }
}
