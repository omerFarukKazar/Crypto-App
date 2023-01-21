//
//  CryptoDetailViewController.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 19.01.2023.
//

import UIKit
import Charts
import Kingfisher

final class CryptoDetailViewController: UIViewController {

    // MARK: - Properties
    private let cryptoView = CryptoDetailView()
    private var viewModel: CryptoDetailViewModel

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coin Detail"
        self.view = cryptoView
        passCoinsData()
    }

    // MARK: Init
    init(viewModel: CryptoDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    /// Assigns the related properties of coin response in ViewModel to the cryptoView.
    func passCoinsData() {
        cryptoView.coinName = viewModel.coin.name ?? "-"
        cryptoView.price = viewModel.coin.prettyPrice
        cryptoView.rate = viewModel.coin.prettyChange
        cryptoView.iconImageView.kf.setImage(with: viewModel.coin.iconUrl)
    }

}
