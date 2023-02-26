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
    /// State that holds the raw value of current segment. In order to change the label and button title.
    private var state: String? {
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

    // MARK: - IBAction
    @IBAction func didTapAuthorizeButton(_ sender: UIButton) {
        guard let email = mailTextField.text,
              let password = passwordTextField.text else { return }

        switch viewModel.segment { // Chooses action with respect to segmented button.
        case .signIn:
            viewModel.signIn(email: email,
                             password: password,
                             completion: { [weak self] in
                self?.setTabBar()
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

    // MARK: - Methods
    /// Prepares the Tab Bar VC with the specified VCs.
    func setTabBar() {
        let cryptoListViewModel = CryptoListViewModel()
        let cryptoListViewController = CryptoListViewController(viewModel: cryptoListViewModel)

        let favoritesViewModel = FavoritesViewModel()
        let favoritesViewController = FavoritesViewController(viewModel: favoritesViewModel)

        let profileViewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(viewModel: profileViewModel)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [cryptoListViewController,
                                            favoritesViewController,
                                            profileViewController]

        tabBarController.tabBar.items?[0].image = UIImage(named: "home")
        tabBarController.tabBar.items?[0].title = "Coins"
        tabBarController.tabBar.items?[1].image = UIImage(named: "favorite")
        tabBarController.tabBar.items?[1].title = "Favorites"
        tabBarController.tabBar.items?[2].image = UIImage(named: "person")
        tabBarController.tabBar.items?[2].title = "Profile"
        // These titles and images could be set with a mapping function and by using enums.

        tabBarController.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(tabBarController, animated: true)
    }
}
