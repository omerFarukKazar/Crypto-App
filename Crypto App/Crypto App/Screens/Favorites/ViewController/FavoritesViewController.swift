//
//  FavoritesViewController.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 29.01.2023.
//

import UIKit

class FavoritesViewController: CAViewController {

    @IBOutlet weak var favoriteCoinsTableView: UITableView!
    private let viewModel: FavoritesViewModel

    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "FavoritesViewController", bundle: nil)
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
