//
//  CollectionViewCell.swift
//  CollectionViewCompositionalLayout
//
//  Created by Pooyan J on 12/29/1403 AP.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    struct Config {
        var amount: Int
        var isSelected: Bool
    }

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var parentView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        parentView.layer.cornerRadius = 8
        parentView.layer.borderWidth = 1
    }

}

// MARK: - Setup Functions
extension CollectionViewCell {

    func setup(config: Config) {
        setupAmountLabel(amount: config.amount)
        setupSelectionStyle(isSelected: config.isSelected)
    }

    private func setupAmountLabel(amount: Int) {
        amountLabel.text = amount.description
        amountLabel.textAlignment = .center
    }

    private func setupSelectionStyle(isSelected: Bool) {
        if isSelected {
            parentView.layer.borderColor = UIColor.systemGreen.cgColor
        } else {
            parentView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
}
