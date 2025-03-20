//
//  ViewController.swift
//  CollectionViewCompositionalLayout
//
//  Created by Pooyan J on 12/29/1403 AP.
//

import UIKit

class ViewController: UIViewController {

    struct Price {
        var amount: Int
        var isSelected: Bool
    }

    @IBOutlet weak var collectionView: UICollectionView!

    let leadingMargin: CGFloat = 16

    var prices: [Price] = [.init(amount: 1000, isSelected: false),
                           .init(amount: 2000, isSelected: false),
                           .init(amount: 3000, isSelected: false),
                           .init(amount: 4000, isSelected: false),
                           .init(amount: 5000, isSelected: false),
                           .init(amount: 6000, isSelected: false)]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
    }


}
// MARK: - Setup Functions
extension ViewController {

    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createCollectionViewCompositionalLayout()
        collectionView.isScrollEnabled = false
    }

    private func createCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let availableWidth = collectionView.bounds.width - (leadingMargin * 3)
        let itemWidth = availableWidth / 3

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemWidth),
            heightDimension: .absolute(itemWidth / 2)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(collectionView.frame.width),
            heightDimension: .absolute(itemWidth / 2 )
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        group.interItemSpacing = .fixed(leadingMargin)

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func selectPrice(at index: Int) {
        for index in prices.indices {
            prices[index].isSelected = false
        }
        prices[index].isSelected = true
    }
}

// MARK: - CollectionView Functions
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        prices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let config: CollectionViewCell.Config = .init(amount: prices[indexPath.row].amount, isSelected: prices[indexPath.row].isSelected)
        cell.setup(config: config)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectPrice(at: indexPath.row)
        collectionView.reloadData()
    }
}
