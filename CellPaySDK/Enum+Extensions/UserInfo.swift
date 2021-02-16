//
//  UserInfo.swift
//  CellPaySDK
//
//  Created by CellPay on 2/12/21.
//  Copyright © 2021 CellPay. All rights reserved.
//

import Foundation
public class UserInfo: NSObject {
     var sessionID     :String?
    class var sharedInstance: UserInfo {
           struct Static {
               static let instance: UserInfo = UserInfo()
           }
           return Static.instance
       }
    func setUserInfo(userInfo:LoginResponse) -> Void {
        if let sessionID  = userInfo.sessionID as? String {
              self.sessionID = sessionID
          }
    }
}
