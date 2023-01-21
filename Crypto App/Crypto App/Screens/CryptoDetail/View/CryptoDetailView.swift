//
//  CryptoView.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 19.01.2023.
//

import UIKit
import Charts

final class CryptoDetailView: UIView {

    // MARK: - Properties
    /// These properties are created to change some properties of private UI Elements from outer scope.
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

    // MARK: - UI Elements
    /// Closures used for Property Initialization because i wanted to change some properties of UI Elements.
    private lazy var coinNameLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.text = "rateLabel"
        return label
    }()

    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 32.0
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Alert", for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()

    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 32.0
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Settings", for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()

    private lazy var chartView: LineChartView = {
        let chart = LineChartView()

        return chart
    }()

    private lazy var addFavoritesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to favorites", for: .normal)
        button.titleLabel?.textColor = .black
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8.0
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
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
            make.size.equalTo(64.0)
        }

        addSubview(alertButton)
        alertButton.snp.makeConstraints { make in
            make.trailing.equalTo(settingsButton.snp.leading).offset(-8.0)
            make.centerY.equalTo(settingsButton.snp.centerY)
            make.size.equalTo(64.0)
        }

        addSubview(chartView)
        chartView.snp.makeConstraints { make in
            make.top.equalTo(rateLabel.snp.bottom).offset(16.0)
            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(addFavoritesButton.snp.top).offset(8.0)
        }

        addSubview(addFavoritesButton)
        addFavoritesButton.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-32)
            make.height.equalTo(48)
        }

    }
}
