//
//  AuthViewController.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 26.01.2023.
//

import UIKit

final class AuthViewController: CAViewController {

    // MARK: - Properties
    private let viewModel: AuthViewModel
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var authStateLabel: UILabel!
    @IBOutlet weak var authButton: UIButton!
    private var state: String? { // state that holds the raw value of current segment. In order to change the label and button title.
        didSet {
            authStateLabel.text = state
            authButton.setTitle(state, for: .normal)
        }
    }

    // MARK: - Init
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "AuthViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Auth"
        state = viewModel.segment.rawValue

        viewModel.authResponse = { change in
            switch change {
            case .isFailure(let error):
                self.showError(error)
            case .isSuccess:
                self.showAlert(title: "Sign Up successful")
            }
        }
    }

    // MARK: - Action
    @IBAction func didTapAuthorizeButton(_ sender: UIButton) {
        guard let email = mailTextField.text,
              let password = passwordTextField.text else { return }

        switch viewModel.segment { // Chooses action with respect to segmented button.
        case .signIn:
//            viewModel.signIn(email: email, password: password) { [weak self] (error) in
//                guard let self = self else { return }
//
//                if let error = error {
//                    self.showError(error)
//                } else {
//                    let viewModel = CryptoListViewModel()
//                    let viewController = CryptoListViewController(viewModel: viewModel)
//                    self.navigationController?.pushViewController(viewController, animated: true)
//                }
//            }
            viewModel.signIn(email: email,
                             password: password,
                             completion: { [weak self] in
                guard let self = self else { return }
                let cryptoListViewModel = CryptoListViewModel()
                let cryptoListViewController = CryptoListViewController(viewModel: cryptoListViewModel)

                self.navigationController?.pushViewController(cryptoListViewController, animated: true)
            })

        case .signUp:
            viewModel.signUp(email: email,
                             password: password)
        }
    }

    /// Changes the enum's value acoording to segmented control's selected segment.
    @IBAction func didSegmentedControlStateChanged(_ sender: UISegmentedControl?) {
        if sender?.selectedSegmentIndex == 0 {
            viewModel.segment = .signIn
        } else if sender?.selectedSegmentIndex == 1 {
            viewModel.segment = .signUp
        }
        state = viewModel.segment.rawValue
    }

}
