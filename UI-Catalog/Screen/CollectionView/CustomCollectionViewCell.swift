//
//  CustomCollectionViewCell.swift
//  UI-Catalog
//
//  Created by Iichiro Kawashima on 2019/04/29.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import UIKit

struct ViewData {
    let image: String
    let title: String
    let description: String
}

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFit
        }
    }

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.adjustsFontSizeToFitWidth = true
            descriptionLabel.minimumScaleFactor = 0.3
        }
    }

    var viewData: ViewData! {
        didSet {
            titleLabel.text = viewData.title
            descriptionLabel.text = viewData.description
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)


        layer.cornerRadius = 8
    }
}
