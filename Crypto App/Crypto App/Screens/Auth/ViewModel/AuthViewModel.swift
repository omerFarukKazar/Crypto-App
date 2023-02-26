//
//  AuthViewModel.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 26.01.2023.
//

import Foundation // Never import UIKit in ViewModel. There should be no UI operations on ViewModel.
import FirebaseAuth
import FirebaseRemoteConfig
import FirebaseFirestore

final class AuthViewModel {

    enum SegmentedControlState: String {
        case signUp = "Sign Up"
        case signIn = "Sign In"
    }

    enum AuthResponse {
        case isSuccess
        case isFailure(_ error: Error)
    }

    // MARK: Properties
    var segment: SegmentedControlState = .signIn
    /// This closure will hold AuthResponse as parameter and not going to return something.
    var authResponse: ((AuthResponse) -> Void)?
    // swiftlint:disable:next identifier_name
    private let db = Firestore.firestore()
    private let defaults = UserDefaults.standard

    // MARK: - Methods
    func signUp(email: String,
                password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.authResponse?(.isFailure(error))
            }

            let user = User(username: authResult?.user.displayName,
                            email: authResult?.user.email,
                            pp: "",
                            favorites: [])

            do {
                guard let data = try user.dictionary,
                      let id = authResult?.user.uid else {
                    return
                }

                self.defaults.set(id, forKey: "uid")

                self.db.collection("users").document(id).setData(data) { error in

                    if let error = error {
                        self.authResponse?(.isFailure(error))
                    } else {
                        self.authResponse?(.isSuccess)
                    }
                }
            } catch {
                self.authResponse?(.isFailure(error))
            }
        }
    }

    func signIn(email: String,
                password: String,
                completion: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        if let error = error {
            self.authResponse?(.isFailure(error))
            return
        }

        guard let id = authResult?.user.uid else {
            return
        }

        self.defaults.set(id, forKey: "uid")

        completion()
    }
    }

}
