//
//  BasePaymentSP.swift
//  CellPaySDK
//
//  Created by CellPay on 2/12/21.
//  Copyright © 2021 CellPay. All rights reserved.
//

import Foundation
protocol InternalCustomValues: Codable {
    var internalName: String { get }
    var fieldID: String { get }
    var value: String { get }
}
struct MemberBasePaymentSP: Codable {
    let transferTypeID, amount, toMemberPrincipal, basePaymentSPDescription: String
    let currencyID: String
    let webRequest: Bool
    let customValues: [BasePaymentCustomValues]
    let isOtpEnable: Bool
    
    enum CodingKeys: String, CodingKey {
        case transferTypeID = "transferTypeId"
        case amount = "amount"
        case toMemberPrincipal = "toMemberPrincipal"
        case basePaymentSPDescription = "description"
        case currencyID = "currencyId"
        case webRequest = "webRequest"
        case customValues = "customValues"
        case isOtpEnable = "isOtpEnable"
    }
}
struct ConfirmMemberBasePaymentSP: Codable {
    let transferTypeID, amount, toMemberPrincipal, basePaymentSPDescription: String
    let currencyID: String
    let transactionPin: String?
    let otp:String?
    let webRequest: Bool
    let customValues: [BasePaymentCustomValues]
    let isOtpEnable: Bool
    
    enum CodingKeys: String, CodingKey {
        case transferTypeID = "transferTypeId"
        case amount = "amount"
        case otp = "otp"
        case transactionPin = "transactionPin"
        case toMemberPrincipal = "toMemberPrincipal"
        case basePaymentSPDescription = "description"
        case currencyID = "currencyId"
        case webRequest = "webRequest"
        case customValues = "customValues"
        case isOtpEnable = "isOtpEnable"
    }
}
struct SystemBasePaymentSP: Codable {
    let transferTypeID, amount, basePaymentSPDescription: String
    let currencyID: String
    let webRequest: Bool
    let customValues: [BasePaymentCustomValues]
    let isOtpEnable: Bool
    
    enum CodingKeys: String, CodingKey {
        case transferTypeID = "transferTypeId"
        case amount = "amount"
        case basePaymentSPDescription = "description"
        case currencyID = "currencyId"
        case webRequest = "webRequest"
        case customValues = "customValues"
        case isOtpEnable = "isOtpEnable"
    }
}

// MARK: - CustomValue
struct BasePaymentCustomValues: InternalCustomValues,Codable {
    let internalName, fieldID, value: String
    
    enum CodingKeys: String, CodingKey {
        case internalName = "internalName"
        case fieldID = "fieldId"
        case value = "value"
    }
    init(_ base:InternalCustomValues) {
        self.fieldID = base.fieldID
        self.internalName = base.internalName
        self.value = base.value
    }
}
struct SelectBankInternalValue: InternalCustomValues {
    var internalName = "SELECTBANK"
     var fieldID: String
    var value: String
    
}

struct PaymentMethodInternalValue: InternalCustomValues {
    var internalName = "PAYMENTMETHOD"
    var fieldID: String
    var value: String
    
}
struct AccountNumberInternalValue: InternalCustomValues {
    var internalName = "ACCOUNTNUMBER"
    var fieldID: String
    var value: String
    
    
}
struct InvoiceNumberInternalValue: InternalCustomValues {
    var internalName = "INVOICENUMBER"
    var fieldID: String
    var value: String
}
