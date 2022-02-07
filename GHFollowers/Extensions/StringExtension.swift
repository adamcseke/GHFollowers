//
//  StringExtension.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 07..
//

import Foundation

extension String {
    /// Localization: Returns a localized string
    ///
    ///        "Hello world".localized -> Hallo Welt
    ///
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
