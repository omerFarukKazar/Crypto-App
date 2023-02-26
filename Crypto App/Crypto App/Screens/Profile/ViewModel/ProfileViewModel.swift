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
    func didGetUserImageData(data: Data)
    func didErrorOccured(error: Error)
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
    /// Fetches Profile Photo  on FirebaseFirestore and sets the delegate's mail property with user's mail on database.
    func fetchProfilePhoto() {
        guard let urlString = UserDefaults.standard.value(forKey: "profilePhotoUrl") as? String,
        let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            self.dataDelegate?.didGetUserImageData(data: data)
        }.resume()
    }
    /// upload profile photo to FirebaseStorage and set image's url to UserDefaults
    ///  - parameters:
    ///     - imageData: The data of picked image that comes from imagePickerController
    func uploadProfilePhoto(with imageData: Data) throws {
        guard let uid = uid else { return }

        storage.child("profilePhotos/").child("\(uid)/profilePhoto.png").putData(imageData) { _, error in
            if let error = error {
                self.dataDelegate?.didErrorOccured(error: error)
            } else {
                self.storage.child("profilePhotos/").child("\(uid)/profilePhoto.png").downloadURL { url, error in
                    guard let url = url, error == nil else { return }

                    let urlString = url.absoluteString
                    UserDefaults.standard.set(urlString, forKey: "profilePhotoUrl")
                }
            }
        }
    }
}
