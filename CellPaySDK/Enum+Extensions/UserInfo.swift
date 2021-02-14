//
//  UserInfo.swift
//  CellPaySDK
//
//  Created by esewa on 2/12/21.
//  Copyright © 2021 esewa. All rights reserved.
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
