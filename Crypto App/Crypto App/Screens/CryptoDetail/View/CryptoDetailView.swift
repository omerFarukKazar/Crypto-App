//
//  CryptoView.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 19.01.2023.
//

import UIKit
import Charts

protocol CryptoDetailViewDelegate: AnyObject {
    func cryptoDetailView(_ view: CryptoDetailView, didTapAddFavoriteButton button: UIButton)
}

final class CryptoDetailView: UIView {

    // MARK: - Properties
    /// These properties are created to change some properties of private UI Elements from outer scope.

    weak var delegate: CryptoDetailViewDelegate?

    var coinName: String? {
        didSet {
            coinNameLabel.text = coinName
        }
    }

    var price: String? {
        didSet {
            priceLabel.text = price
        }
    }

    var rate: String? {
        didSet {
//            rateLabel.textColor = ChangeRate.changeTextColor(by: rate)
            rateLabel.text = rate
        }
    }

    var isRatePositive: Bool? { // Flag for changing rateLabel color depending to the change rate.
        didSet {
            guard let isRatePositive = isRatePositive else { return }
            if isRatePositive {
                rateLabel.textColor = .green
            } else {
                rateLabel.textColor = .red
            }
        }
    }
    // MARK: - UI Elements
    /// Closures used for Property Initialization because i wanted to change some properties of UI Elements.
    private lazy var coinNameLabel: UILabel = {
        let label = UILabel()
        // Some properties like font could be changed.
        return label
    }()

    lazy var iconImageView: UIImageView = UIImageView()
    // Since there is no additional changes, it's easier to instantiate without closure.

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0)
        return label
    }()

    private lazy var rateLabel: UILabel = UILabel()

    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 22.0
        button.setTitleColor(.black, for: .normal)
        button.setTitle("🔔", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.layer.borderWidth = 1
        return button
    }()

    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 22.0
        button.setTitleColor(.black, for: .normal)
        button.setTitle("⚙️", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.layer.borderWidth = 1
        return button
    }()

    private(set) lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.doubleTapToZoomEnabled = false
        chartView.drawGridBackgroundEnabled = true
        chartView.gridBackgroundColor = .white
        chartView.xAxis.labelCount = 3
        chartView.leftAxis.enabled = false
        chartView.chartDescription.enabled = false
        chartView.legend.enabled = false
        chartView.animate(xAxisDuration: 2)
        return chartView
    }()

    lazy var addFavoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to favorites", for: .normal)
        button.titleLabel?.textColor = .black
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(didTapAddFavoriteButton(_:)), for: .touchUpInside)
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        print(frame.height)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

    // MARK: - Methods
    /// set the layout using SnapKit
    func setupLayout() {
        addSubview(coinNameLabel)
        coinNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(20.0)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32.0)
        }

        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.leading.equalTo(coinNameLabel.snp.trailing).offset(8.0)
            make.centerY.equalTo(coinNameLabel.snp.centerY)
            make.size.equalTo(32.0)
        }

        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.top.equalTo(coinNameLabel.snp.bottom).offset(8.0)
        }

        addSubview(rateLabel)
        rateLabel.snp.makeConstraints { make in
            make.leading.equalTo(20.0)
            make.top.equalTo(priceLabel.snp.bottom).offset(8.0)
        }

        addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.trailing.equalTo(-20.0)
            make.centerY.equalTo(priceLabel.snp.centerY)
            make.size.equalTo(42.0)
        }

        addSubview(alertButton)
        alertButton.snp.makeConstraints { make in
            make.trailing.equalTo(settingsButton.snp.leading).offset(-8.0)
            make.centerY.equalTo(settingsButton.snp.centerY)
            make.size.equalTo(42.0)
        }

        addSubview(lineChartView)
        lineChartView.snp.makeConstraints { make in
            make.top.equalTo(rateLabel.snp.bottom).offset(16.0)
            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(addFavoritesButton.snp.top).offset(8.0)
        }

        addSubview(addFavoriteButton)
        addFavoriteButton.snp.makeConstraints { make in
            make.top.equalTo(lineChartView.snp.bottom).offset(32.0)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-32)
            make.height.equalTo(48)
        }
    }

    /// Function to set lineChartView's delegate to given parameter.
    ///  - parameters:
    ///     - delegate: a delegate which has type of ChartViewDelegate
    func setChartViewDelegate(_ delegate: ChartViewDelegate) {
        lineChartView.delegate = delegate
    }

    @objc
    private func didTapAddFavoriteButton(_ sender: UIButton) {
        delegate?.cryptoDetailView(self, didTapAddFavoriteButton: sender)
    }
}
