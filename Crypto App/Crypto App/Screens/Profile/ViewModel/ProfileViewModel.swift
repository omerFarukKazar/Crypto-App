//
//  ProfileViewModel.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 26.02.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol UserDataSetter: AnyObject {
    func didGetUserMail(mail: String)
}

final class ProfileViewModel: CAViewModel {

    // MARK: - Properties
    // swiftlint:disable:next identifier_name
    private let db = Firestore.firestore()
    private let storage = Storage.storage().reference()
    weak var dataDelegate: UserDataSetter?
    // MARK: - Methods
    /// Fetches User data on FirebaseFirestore and sets the delegate's mail property with user's mail on database.
    func fetchUser() {
        guard let uid = uid else { return }

        db.collection("users").document(uid).getDocument { querySnapshot, _ in
            guard let data = querySnapshot?.data() else { return }
            let user = User(from: data)

            guard let eMail = user.email else { return }
            self.dataDelegate?.didGetUserMail(mail: eMail)
        }
    }
}
