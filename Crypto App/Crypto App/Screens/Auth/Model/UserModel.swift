//
//  UserModel.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 26.01.2023.
//

import Foundation

struct User: Encodable {
//    let username: String?
    let email: String?
    // swiftlint:disable:next identifier_name
    let pp: String?
    let favorites: [String]?
}

extension User {
    init(from dict: [String: Any]) {
//        username = dict["username"] as? String
        email = dict["email"] as? String
        pp = dict["pp"] as? String
        favorites = dict["favorites"] as? [String]
    }
}
