//
//  Style.swift
//  UI-Catalog
//
//  Created by Iichiro Kawashima on 2019/04/29.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import UIKit

enum Style {
    // デフォルトはSystemFont(SF Pro)
    //ファイルを追加することでカスタムフォントも使用できる。
    struct Font {
        static let font11: CGFloat = 11
        static let font15: CGFloat = 15
        static let font20: CGFloat = 20
    }

    struct Color {
        /// #F26161
        static let coral = #colorLiteral(red: 0.9490196078, green: 0.3803921569, blue: 0.3803921569, alpha: 1)
        /// #F7F8FA
        static let snowWhite = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9803921569, alpha: 1)
    }
}
