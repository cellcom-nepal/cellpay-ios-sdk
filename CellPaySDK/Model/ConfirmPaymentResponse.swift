//
//  ConfirmPaymentResponse.swift
//  CellPaySDK
//
//  Created by CellPay on 2/12/21.
//  Copyright © 2021 CellPay. All rights reserved.
//

import Foundation
public struct ConfirmPaymentResponse: Codable {
    public let status, sessionExpired: Bool
    public let payload: ConfirmPaymentPayload
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case sessionExpired = "sessionExpired"
        case payload = "payload"
    }
}

// MARK: - Payload
public struct ConfirmPaymentPayload: Codable {
    public let confirmPaymentResult: ConfirmPaymentResult
    
    enum CodingKeys: String, CodingKey {
        case confirmPaymentResult = "ConfirmPaymentResult"
    }
}

// MARK: - ConfirmPaymentResult
public struct ConfirmPaymentResult: Codable {
    public let id: Int
    public let pending: Bool
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case pending = "pending"
    }
}
