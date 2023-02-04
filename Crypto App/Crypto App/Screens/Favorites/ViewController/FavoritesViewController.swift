//
//  FavoritesViewController.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 29.01.2023.
//

import UIKit

final class FavoritesViewController: CAViewController {

    // MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    private let viewModel: FavoritesViewModel // Hence viewModel doesn't hold a UIController, there is no need to use weak property.
    private var isAnyCoinAddedToFavorites: Bool = true

    // MARK: - Init
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "CoinTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")

        NotificationCenter().addObserver(self,
                                         selector: #selector(self.didAnyCoinAddedToFavorites),
                                         name: NSNotification.Name("didAnyCoinAddedToFavorites"),
                                         object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isAnyCoinAddedToFavorites = true
        fetchFavorites()
    }

    // MARK: - Methods
    private func fetchFavorites() {
        if isAnyCoinAddedToFavorites {
            isAnyCoinAddedToFavorites = false
            viewModel.fetchFavorites { error in
                if let error = error {
                    self.showError(error)
                } else {
                    self.tableView.reloadData()
                }
            }
        }
    }

    @objc private func didAnyCoinAddedToFavorites() {
        isAnyCoinAddedToFavorites = true
    }

}

// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CoinTableViewCell else {
            fatalError("CoinTableViewCell not found.")
        }
        guard let coin = viewModel.coinForIndexPath(indexPath) else {
            fatalError("coin not found.")
        }

        cell.title = coin.name
        cell.price = coin.prettyPrice
        cell.imageView?.kf.setImage(with: coin.iconUrl) { _ in
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }

        return cell
    }
}
