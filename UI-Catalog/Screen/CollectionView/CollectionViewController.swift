//
//  CollectionViewController.swift
//  UI-Catalog
//
//  Created by Iichiro Kawashima on 2019/04/29.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    typealias DataSource = CollectionViewDataSource<CustomCollectionViewCell, ViewData>
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: CustomCollectionViewCell.className, bundle: nil),
                                    forCellWithReuseIdentifier: CustomCollectionViewCell.className)
            collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.className)
            collectionView.register(SectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SectionFooterView.className)
            collectionView.dataSource = dataSource

            // Todo: collectionviewflowlayout適用
        }
    }

    private lazy var dataSource: DataSource = {
        return CollectionViewDataSource(
        cellReuseIdentifier: CustomCollectionViewCell.className) { [unowned self]  cell, item, _ in
            cell.viewData = item
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
