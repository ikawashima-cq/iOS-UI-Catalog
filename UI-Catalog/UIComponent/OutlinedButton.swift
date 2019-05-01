//
//  OutlinedButton.swift
//  UI-Catalog
//
//  Created by Iichiro Kawashima on 2019/04/30.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class OutlinedButton: UIButton {

    @IBInspectable var borderWidth: CGFloat = 1
    @IBInspectable var borderColor: UIColor = .lightGray

    // 参考URL: https://egg-is-world.com/2018/07/05/custom-view-initialize/
    // cutomViewは作成方法によってイニシャライザが異なる。
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }

    private func commonInit() {
        isExclusiveTouch = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
}
