//
//  AuthViewModel.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 26.01.2023.
//

import Foundation
import FirebaseAuth

final class AuthViewModel {

    enum SegmentedControlState: String {
        case signUp = "Sign Up"
        case signIn = "Sign In"
    }

    enum AuthResponse {
        case isSuccess
        case isFailure(Error)
    }

    // MARK: Properties
    var segment: SegmentedControlState = .signIn
    var authResponse: ((AuthResponse) -> Void)?
    var user: User

    // MARK: - Init
    init(user: User) {
        self.user = user
    }

    // MARK: - Methods
    func signUp(eMail: String,
                password: String,
                completion: @escaping (Error) -> Void) {
        Auth.auth().createUser(withEmail: eMail, password: password) { authResult, error in
            if let error = error {
                self.authResponse?(.isFailure(error))
                completion(error)
            } else {
                self.user.eMail = authResult?.user.email
                self.authResponse?(.isSuccess)
            }
        }
    }

    func signIn(eMail: String,
                password: String,
                completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: eMail, password: password) { authResult, error in
            if let error = error {
                self.authResponse?(.isFailure(error))
                completion(error)
            } else {
                self.authResponse?(.isSuccess)
                completion(nil)
            }
        }
    }

}
