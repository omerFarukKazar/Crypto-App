//
//  FavoritesViewController.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 29.01.2023.
//

import UIKit

class FavoritesViewController: CAViewController {

    @IBOutlet weak var favoriteCoinsTableView: UITableView!
    private let viewModel: FavoritesViewModel // Hence viewModel doesn't hold a UIController, there is no need to use weak property.
    private var isAnyCoinAddedToFavorites: Bool = true

    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"

        let nib = UINib(nibName: "CoinTableViewCell", bundle: nil)
        favoriteCoinsTableView.register(nib, forCellReuseIdentifier: "cell")

        viewModel.fetchFavorites { error in
            if let error = error {
                self.showError(error)
            } else {
                self.favoriteCoinsTableView.reloadData()
            }
        }
    }

}

extension FavoritesViewController: UITableViewDelegate {

}

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
