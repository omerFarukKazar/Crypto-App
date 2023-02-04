//
//  ProfileViewController.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 2.02.2023.
//

import UIKit
import FirebaseAuth

final class ProfileViewController: CAViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction private func didTapSignOutButton(_ sender: UIButton) {
        showAlert(title: "Warning",
                  message: "Are you sure to Sign Out?",
                  addCancelButton: true,
                  handler: { [weak self] (_) in
            do {
                try Auth.auth().signOut()
                self?.navigationController?.popToRootViewController(animated: true)
            } catch {
                self?.showError(error)
            }
        })
    }

}
