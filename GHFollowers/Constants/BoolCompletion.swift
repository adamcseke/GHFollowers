//
//  BoolCompletion.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 15..
//

import UIKit

typealias BoolCompletition = (Bool) -> Void

//swiftlint:disable force_cast
let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

struct Constants {
    
    struct UserDefaults {
    }
}

extension Notification.Name {
    static let ReloadUserList = Notification.Name("ReloadUserList")
}
