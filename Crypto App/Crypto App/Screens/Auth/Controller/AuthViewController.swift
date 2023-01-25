//
//  AuthViewController.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 26.01.2023.
//

import UIKit

final class AuthViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Auth"

    }

    // MARK: - Button Actions
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        print("Login")
        let viewModel = CryptoListViewModel()
        let viewController = CryptoListViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        print("Sign-Up")
    }

}
