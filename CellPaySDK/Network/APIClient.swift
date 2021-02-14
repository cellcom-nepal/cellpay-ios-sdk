//
//  APIClient.swift
//  CellPaySDK
//
//  Created by esewa on 2/12/21.
//  Copyright © 2021 esewa. All rights reserved.
//

import Foundation
public class APIClient:NSObject {
    public func sendRequest(_ url: String, parameters: [String: Any]?,method:HTTPMethod.RawValue,userName:String?=nil,password:String?=nil, completion: @escaping ResultCallback<Data>) {
        guard Luminous.Network.isInternetAvailable else {
            completion(.failure(APIError.unreachable))
            return
        }
        let webUrl = URL(string: WebService.baseUrl + url)!
        
        var request = URLRequest(url: webUrl)
        
        request.httpMethod = method
        if url == WebService.login {
            let username = userName ?? ""
            let password = password ?? ""
            let loginString = NSString(format: "%@:%@", username, password)
            guard let loginData = loginString.data(using: String.Encoding.utf8.rawValue) else {
                return
            }
            let base64LoginString = loginData.base64EncodedString()
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            
        }
        if (url == WebService.accounts) || (url == WebService.memberPayment) || (url == WebService.confirmMemberPayment){
            request.setValue("\(UserInfo.sharedInstance.sessionID ?? "")", forHTTPHeaderField: "Paynet-Session-Token")
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if parameters != nil {
            //request.httpBody = parameters?.percentEncoded()
            // https://stackoverflow.com/a/31938246
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters as Any)
        }
        //        https://stackoverflow.com/a/24380884
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
               
               
                let responseMessage = try? JSONDecoder().decode(CellPayMessageError
                    .self, from: data!)
                print(responseMessage as Any)
                completion(.failure(APIError.message(responseMessage?.errors.first?.shortMessage ?? "Something went wrong. Please try again")))
                print(APIError.message(responseMessage?.errors.first?.shortMessage ?? "Something went wrong. Please try again"))
                DispatchQueue.main.async {
                    let snackbar = TTGSnackbar(message: responseMessage?.errors.first?.shortMessage ?? "Something went wrong. Please try again", duration: .long)
                    snackbar.show()
                }
                
            }
            
           
                
                //            guard let data = data,                            // is there data
                //                let response = response as? HTTPURLResponse,  // is there HTTP response
                //                (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                //                error == nil else {                           // was there no error, otherwise ...
                //
                //                    completion(.failure(APIError.message(error?.localizedDescription ?? "")))
                //                    return
                //            }
            else if let data = data , error == nil {
                let json =  try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                let jsonData = self.jsonEncode(object: json)
                completion(.success(jsonData!))
            }
            
            
        }
        task.resume()
    }
    public func jsonEncode(object: Any?) -> Data? {
        if let object = object {
            
            return try? JSONSerialization.data(withJSONObject: object, options:[])
            
        }
        
        return nil
    }
    
    
    
}
