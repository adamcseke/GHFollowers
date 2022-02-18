//
//  Devices.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 17..
//

import UIKit

extension UIDevice {
    
    enum Devices {
        static var iPhoneSE1stGen: Bool { UIScreen.main.nativeBounds.height == 1136 }
        static var iPad: Bool { UIDevice().userInterfaceIdiom == .pad }
    }
    
    enum ScreenType: String {
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1136: return .iPhones_5_5s_5c_SE
        default: return .unknown
        }
    }
}
