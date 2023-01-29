//
//  Encodable+Extension.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 29.01.2023.
//

import Foundation

// This extension is used to store Coins data as a Dictionary because Firebase Firestore wants input parameter to be a Dictionary.
extension Encodable {
    var dictionary: [String: Any]? {
        get throws { // Throwing getter
            let data = try JSONEncoder().encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data,
                                                              options: .allowFragments) as? [String: Any]
            return dictionary
        }
    }
}
