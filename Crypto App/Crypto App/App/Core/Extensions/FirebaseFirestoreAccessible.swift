//
//  FirebaseFirestoreAccessible.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 1.02.2023.
//

import Foundation
import FirebaseFirestore

protocol FireBaseFireStoreAccessible {}

extension FireBaseFireStoreAccessible {
    // swiftlint:disable:next identifier_name
    var db: Firestore {
        Firestore.firestore()
    }
}
