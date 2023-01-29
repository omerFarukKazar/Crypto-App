//
//  CryptoListViewController.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 14.01.2023.
//

import UIKit
import Kingfisher

final class CryptoListViewController: CAViewController {
    // MARK: - Xib Elements
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    private let viewModel: CryptoListViewModel // Dependency Injection
    // MARK: - Init
    init(viewModel: CryptoListViewModel) { // Dependency Injection
        self.viewModel = viewModel
        super.init(nibName: "CryptoListViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Coins"
        let nib = UINib(nibName: "CoinTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")

        viewModel.fetchCoins() // Try to fetch Coins
        viewModel.changeHandler = { change in // Take action by the result
            switch change {
            case .didFetchCoins:
                self.tableView.reloadData()
            case .didErrorOccured(let error):
                print(error.localizedDescription)
            }
        }
    }

}

// MARK: - UITableViewDelegate
extension CryptoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let coin = viewModel.coinForIndexPath(indexPath) else { return }
        let viewModel = CryptoDetailViewModel(coin: coin)
        let viewController = CryptoDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension CryptoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CoinTableViewCell else { fatalError("CoinTableViewCell not found")
        }
        guard let coin = viewModel.coinForIndexPath(indexPath) else { fatalError("Coin can't be found") }
            cell.title = coin.name
            cell.price = coin.prettyPrice
            cell.imageView?.kf.setImage(with: coin.iconUrl) { _ in
                tableView.reloadRows(at: [indexPath], with: .none)
        }
        return cell
    }

}
