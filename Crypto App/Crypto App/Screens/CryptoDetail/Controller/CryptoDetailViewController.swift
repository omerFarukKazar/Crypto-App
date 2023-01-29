//
//  CryptoDetailViewController.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 19.01.2023.
//

import UIKit
import Charts
import Kingfisher

final class CryptoDetailViewController: CAViewController {

    // MARK: - Properties
    private lazy var cryptoView = CryptoDetailView()
    private var viewModel: CryptoDetailViewModel

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coin Detail"
        self.view = cryptoView
        passCoinsData()
        viewModel.delegate = self
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
        cryptoView.isRatePositive = viewModel.isRatePositive
        cryptoView.setChartViewDelegate(self)
        viewModel.fetchChart()
    }

    /// Takes the entries by mapping the chart data response. Creates the chart and line according to those entries. Passes that chart data to viewModel.
    func setData() {
        guard let entries = (viewModel.chartResponse?.chart?.map { (metrics) -> ChartDataEntry in
            return ChartDataEntry(x: metrics[0],
                                  y: metrics[1])
        }) else {
            return
        }

        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.liberty()
        set.drawCirclesEnabled = false
        set.lineWidth = 1.7
        set.setColor(.red)

        let data = LineChartData(dataSet: set)
        cryptoView.lineChartView.data = data
    }

}

// MARK: - CryptoDetailDelegate
extension CryptoDetailViewController: CryptoDetailDelegate {

    func didErrorOccured(_ error: Error) {
        showAlert(title: "An Error Occured", message: error.localizedDescription)
    }

    func didFetchChart() {
        setData()
    }
    
    func didCoinAddedToFavorites() {

    }
}

// MARK: - ChartViewDelegate
extension CryptoDetailViewController: ChartViewDelegate {

}
