//
//  DateExtensions.swift
//  CellPaySDK
//
//  Created by CellPay on 2/12/21.
//  Copyright © 2021 CellPay. All rights reserved.
//

import Foundation
public extension Data {
    func decode<T: Decodable>(to type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            //                        formatter.dateFormat = "yyyy-MM-dd"
            formatter.dateFormat = "dd/M/yyyy h:mm:ss a"
            return formatter
        }()
        
        decoder.dateDecodingStrategy = .formatted(formatter)
        return try decoder.decode(T.self, from: self)
    }
}
