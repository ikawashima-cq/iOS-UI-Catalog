//
//  CustomPresentationViewController.swift
//  UI-Catalog
//
//  Created by Iichiro Kawashima on 2019/05/05.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import UIKit

class CustomPresentationController: UIPresentationController {

    private var overlay = UIView()
    private let margin = (x: CGFloat(30), y: CGFloat(220.0))

    override func presentationTransitionWillBegin() {

        let containerView = self.containerView!
        overlay.frame = containerView.bounds
        overlay.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(CustomPresentationController.didTouchOverlay(_:)))]
        overlay.backgroundColor = .black
        overlay.alpha = 0.0
        containerView.insertSubview(self.overlay, at: 0)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [unowned self] _ in
            self.overlay.alpha = 0.5
        })
    }

    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [unowned self] _ in
            self.overlay.alpha = 0.0
        })
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.overlay.removeFromSuperview()
        }
    }

    // 子のコンテナサイズを返す
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width - margin.x, height: parentSize.height - margin.y)
    }

    // 呼び出し先のView Controllerのframeを返す
    override var frameOfPresentedViewInContainerView: CGRect {
        var presentedViewFrame = CGRect()
        let containerBounds = containerView!.bounds
        let childContentSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerBounds.size)
        presentedViewFrame.size = childContentSize
        presentedViewFrame.origin.x = margin.x / 2.0
        presentedViewFrame.origin.y = margin.y / 2.0

        return presentedViewFrame
    }

    // レイアウト開始前に呼ばれる
    override func containerViewWillLayoutSubviews() {
        overlay.frame = containerView!.bounds
        presentedView?.frame = frameOfPresentedViewInContainerView
        presentedView?.layer.cornerRadius = 10
        presentedView?.clipsToBounds = true
    }

    @objc private func didTouchOverlay(_ sender: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true)
    }
}
