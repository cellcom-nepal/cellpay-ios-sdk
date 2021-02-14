//
//  Luminous.swift
//  CellPaySDK
//
//  Created by esewa on 2/12/21.
//  Copyright © 2021 esewa. All rights reserved.
//

import Foundation
import SystemConfiguration.CaptiveNetwork
import CoreMotion
import CoreTelephony
import ExternalAccessory
import Foundation
public struct Luminous {
    
    
    // MARK: Types
    
    /// The battery state.
    ///
    /// - unknown:   State unknown.
    /// - unplugged: Battery is not plugged in.
    /// - charging:  Battery is charging.
    /// - full:      Battery is full charged.
    public enum BatteryState: Int {
        case unknown
        case unplugged
        case charging
        case full
    }
    
    /// The size scale to decide how you want to obtain size information.
    ///
    /// - bytes:     In bytes.
    /// - kilobytes: In kilobytes.
    /// - megabytes: In megabytes.
    /// - gigabytes: In gigabytes.
    public enum MeasureUnit {
        case bytes
        case kilobytes
        case megabytes
        case gigabytes
        case percentage
    }
}
