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
    var db: Firestore {
        Firestore.firestore()
    }
}
