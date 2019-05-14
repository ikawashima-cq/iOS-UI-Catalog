//
//  CollectionViewDataSource.swift
//  UI-Catalog
//
//  Created by Iichiro Kawashima on 2019/04/29.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewDataSource<CellType, EntityType>: NSObject, UICollectionViewDataSource {

    private let cellReuseIdentifier: String
    private let cellConfigurationHandler: (CellType, EntityType, IndexPath) -> Void

    private var listItems = [EntityType]()

    init(cellReuseIdentifier: String,
    cellConfigurationHandler: @escaping (CellType, EntityType, IndexPath) -> Void) {
        self.cellReuseIdentifier = cellReuseIdentifier
        self.cellConfigurationHandler = cellConfigurationHandler
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        CollectionViewData.sectionNumber = 6
        return 6
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCollectionViewCell.className,
            for: indexPath)

        guard !listItems.isEmpty else { return cell }

        let item = listItems[indexPath.row]

        if let cell = cell as? CellType {
            cellConfigurationHandler(cell, item, indexPath)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.className, for: indexPath) as? SectionHeaderView else {
            fatalError("Could not find proper header")
        }

        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SectionFooterView.className, for: indexPath) as? SectionFooterView else {
            fatalError("Could not find proper header")
        }

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            header.backgroundColor = .yellow
            return header
        case UICollectionView.elementKindSectionFooter:
            footer.backgroundColor = .blue
            return footer
        default:
            return UICollectionReusableView()
        }
    }
}

extension CollectionViewDataSource {
    func set(listItems: [EntityType]) {
        self.listItems = listItems
    }

    func getItem(index: Int) -> EntityType {
        return self.listItems[index]
    }
}
