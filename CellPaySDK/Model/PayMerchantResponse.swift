//
//  PayMerchantResponse.swift
//  CellPaySDK
//
//  Created by esewa on 2/12/21.
//  Copyright © 2021 esewa. All rights reserved.
//

import Foundation
struct PaymentMerchantResponse: Codable {
    let status, sessionExpired: Bool
    let payload: MerchantPayload
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case sessionExpired = "sessionExpired"
        case payload = "payload"
    }
}

// MARK: - Payload
struct MerchantPayload: Codable {
    let doPaymentResult: DoPaymentResult
    
    enum CodingKeys: String, CodingKey {
        case doPaymentResult = "DoPaymentResult"
    }
}
//
//// MARK: - DoPaymentResult
struct DoPaymentResult: Codable {
    //    let wouldRequireAuthorization: Bool
    //    let from, to: DoPaymentResultFrom
    //    let finalAmount: Int
    //    let formattedFinalAmount: String
    //    let fees: [Fee]
    //    let transferType: TransferType
    //    let customValues: [DoPaymentCustomValue]
    let isOtpEnable: Bool
    //    let consolidatedAmount: Int
    //    let consolidatedFormatterAmount: String
    //    let showConsolidateAmount: Bool
    enum CodingKeys: String, CodingKey {
//        case wouldRequireAuthorization = "wouldRequireAuthorization"
//        case from = "from"
//        case to = "to"
//        case finalAmount = "finalAmount"
//        case formattedFinalAmount = "formattedFinalAmount"
//        case fees = "fees"
//        case transferType = "transferType"
//        case customValues = "customValues"
        case isOtpEnable = "isOtpEnable"
//        case consolidatedAmount = "consolidatedAmount"
//        case consolidatedFormatterAmount = "consolidatedFormatterAmount"
//        case showConsolidateAmount = "showConsolidateAmount"
    }
}
//
//// MARK: - CustomValue
//struct DoPaymentCustomValue: Codable {
//    let internalName: String
//    let fieldID: Int
//    let value: String
//
//    enum CodingKeys: String, CodingKey {
//        case internalName = "internalName"
//        case fieldID = "fieldId"
//        case value = "value"
//    }
//}
//
//// MARK: - Fee
//struct Fee: Codable {
//    let name: String
//    let amount: Int
//    let formattedAmount: String
//    enum CodingKeys: String, CodingKey {
//           case name = "name"
//           case amount = "amount"
//           case formattedAmount = "formattedAmount"
//       }
//}
//
//// MARK: - DoPaymentResultFrom
//struct DoPaymentResultFrom: Codable {
//    let id: Int
//    let name, username, mobileNo: String
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case username = "username"
//        case mobileNo = "mobileNo"
//    }
//}
//
//// MARK: - TransferType
//struct TransferType: Codable {
//    let id: Int
//    let name: String
//    let from, to: TransferTypeFrom
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case from = "from"
//        case to = "to"
//    }
//}
//
//// MARK: - TransferTypeFrom
//struct TransferTypeFrom: Codable {
//    let id: Int
//    let name: String
//    let currency: Currency
//}
//
//// MARK: - Currency
//struct Currency: Codable {
//    let id: Int
//    let symbol, name: String
//}
