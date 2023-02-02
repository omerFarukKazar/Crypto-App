//
//  UserDefaultsAccessible.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 1.02.2023.
//

import Foundation

protocol UserDefaultsAccessible {}

extension UserDefaultsAccessible {
    var defaults: UserDefaults {
        UserDefaults.standard
    }

    var uid: String? {
        stringDefault(for: .uid)
    }

    func stringDefault(for key: UserDefaultConstants) -> String? {
        defaults.string(forKey: key.rawValue)
    }
}
