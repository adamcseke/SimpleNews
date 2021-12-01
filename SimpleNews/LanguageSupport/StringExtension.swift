//
//  StringExtension.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 12. 08..
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
