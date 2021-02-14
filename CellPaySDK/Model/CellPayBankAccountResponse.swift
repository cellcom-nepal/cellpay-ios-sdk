//
//  CellPayBankAccountResponse.swift
//  CellPaySDK
//
//  Created by esewa on 2/12/21.
//  Copyright © 2021 esewa. All rights reserved.
//

import Foundation
struct BankAccountResponse: Codable {
    let status, sessionExpired: Bool
    public let payload: Payloads
}

// MARK: - Payload
struct Payloads: Codable {
     public let memberDetailsList: [MemberDetailsList]

    enum CodingKeys: String, CodingKey {
        case memberDetailsList = "MemberDetailsList"
    }
}

// MARK: - MemberDetailsList
struct MemberDetailsList: Codable {
    let memberID, memberRecordID: Int
    let memberName, userName, accountNo: String
    let memberDetailsListDefault: Bool

    enum CodingKeys: String, CodingKey {
        case memberID = "memberId"
        case memberRecordID = "memberRecordId"
        case memberName = "memberName"
        case userName = "userName"
        case accountNo = "accountNo"
        case memberDetailsListDefault = "default"
    }
}
