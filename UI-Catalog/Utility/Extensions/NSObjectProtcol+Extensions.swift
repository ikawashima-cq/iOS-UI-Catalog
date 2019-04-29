//
//  NSObjectProtcol+Extensions.swift
//  UI-Catalog
//
//  Created by Iichiro Kawashima on 2019/04/29.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation

// class名の取得
extension NSObjectProtocol {
    static var className: String {
        return String(describing: self)
    }
}
