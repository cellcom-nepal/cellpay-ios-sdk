//
//  CellPayPaymentArguments.swift
//  CellPaySDK
//
//  Created by CellPay on 2/12/21.
//  Copyright © 2021 CellPay. All rights reserved.
//

import Foundation
public protocol PaymentProtocol {
    func sucess(paymentResponse: ConfirmPaymentResponse,cellPayArguments: CellPayPaymentArguments)
    func failed(cellPayArguments:CellPayPaymentArguments)
}
public class CellPayPaymentArguments {
    
    public let mobileNumber: String?
//    let imageUrl: String?
    public let merchantName: String
    public let paymentType:Int?
    public let price:Int?
    public let invoiceID: String?
  
    
    public init(mobileNumber:String,merchantName:String,paymentType:Int,price:Int,invoiceID:String) {
        self.mobileNumber = mobileNumber
//        self.imageUrl = imageUrl
        self.merchantName = merchantName
        self.paymentType = paymentType
        self.price = price
        self.invoiceID = invoiceID

    }
    
//    func onSuccess(_ completion: (String) -> Void) {
//
//    }
}
