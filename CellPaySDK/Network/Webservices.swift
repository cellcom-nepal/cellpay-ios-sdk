//
//  Webservices.swift
//  CellPaySDK
//
//  Created by esewa on 2/12/21.
//  Copyright © 2021 esewa. All rights reserved.
//

import Foundation
public class WebService {
    public static var shared: WebService {
        return singleton
    }
    private static let singleton: WebService = WebService()
    
    //let BaseUrl:String = "https://web.cellpay.com.np/rest/"
    
    static var isLive: Bool = false
    
    public static var baseUrl: String {
        return isLive ? "https://web.cellpay.com.np/rest/" : "https://test.cellpay.com.np/rest/"
    }
    public static var login: String {
        return isLive ? "access/login" : "access/login"
    }
    public static var accounts: String {
        return isLive ? "memberRecord/accounts" : "memberRecord/accounts"
    }
    public static var memberPayment: String {
        return isLive ? "payments/memberPayment" : "payments/memberPayment"
    }
    public static var confirmMemberPayment: String {
           return isLive ? "payments/confirmMemberPayment" : "payments/confirmMemberPayment"
       }
    
}
