//
//  CryptoListViewController.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 14.01.2023.
//

import UIKit

class CryptoListViewController: UIViewController {
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

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

}

// MARK: - UITableViewDataSource
extension CryptoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.coinForIndexPath(indexPath)?.name
        return cell
    }

}
