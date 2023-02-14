//
//  SpotifyViewController.swift
//  Spotify-Playlist
//
//  Created by Iyin Raphael on 2/8/23.
//

import UIKit

class SpotifyViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var spotifyCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<String, [Item]>?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeDataSource()
        configureCollectionView()

    }
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Private Methods
    private func configureCollectionView() {
        spotifyCollectionView.collectionViewLayout = makeCollectionViewLayout()
    }

    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }

    private func makeDataSource() {
        let cellNib = UINib(nibName: "ItemViewCell", bundle: .main)
        let itemCellView = UICollectionView.CellRegistration<ItemViewCell, [Item]>(cellNib: cellNib) { cell, indexPath, items in
            let item = items[indexPath.item]
            cell.updateCell(with: item)
        }

        dataSource = UICollectionViewDiffableDataSource<String, [Item]>(collectionView: spotifyCollectionView) { [weak self] (collectionView, indexPath, items) -> UICollectionViewCell? in

            guard let dataSource = self?.dataSource else { return nil }

            let sectionIdentifier = dataSource.snapshot().sectionIdentifiers[indexPath.item]


            return collectionView.dequeueConfiguredReusableCell(using: itemCellView, for: indexPath, item: items)
        }
    }

    private func updateDataSource(with entity: SpotifyEntity? ) {
        if let items = entity?.items {
            var snapshot = NSDiffableDataSourceSnapshot<String, [Item]>()

            for _ in items {
                let header = "Items"
                snapshot.appendItems([items], toSection: header)
            }

            dataSource?.apply(snapshot)
        }
    }

}
