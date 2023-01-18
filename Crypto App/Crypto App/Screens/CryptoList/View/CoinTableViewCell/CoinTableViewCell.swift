//
//  CoinTableViewCell.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 18.01.2023.
//

import UIKit

class CoinTableViewCell: UITableViewCell {
    // MARK: - Properties
    var title: String? { // Computed property. Doesn't allocate memory. Re-calculated each time it's called.
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }

    var price: String? { // Allocates memory in ram
        didSet {
            priceLabel.text = price
        }
    }
    // MARK: - xib connections
    @IBOutlet private(set) weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
