//
//  LaunchViewController.swift
//  UI-Catalog
//
//  Created by member on 2019/05/19.
//  Copyright © 2019年 Iichiro Kawashima. All rights reserved.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController {

    struct Const {
        static let waveAnimation = "wave_animation"
        static let dinoAnimation = "dino_loading_animation"
    }

    @IBOutlet weak var animationView: AnimationView! {
        didSet {
            /**
             MARK: - Use of undeclared type 'LOTAnimationView' · Issue #847 · airbnb/lottie-ios
             https://github.com/airbnb/lottie-ios/issues/847
             AnimationView causes crash when initialized in Interface Builder · Issue #826 · airbnb/lottie-ios
             https://github.com/airbnb/lottie-ios/issues/826
             */
            let animation = Animation.named(Const.waveAnimation)
            animationView.animation = animation
            animationView.contentMode = .scaleAspectFill
            animationView.backgroundColor = .clear
            animationView.animationSpeed = 1
        }
    }

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .white
            titleLabel.font = UIFont.systemFont(ofSize: 28)
            titleLabel.textAlignment = .center
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MainViewController.className)
        let nc = UINavigationController(rootViewController: vc)

        animationView.play { [weak self] _ in
            self?.animationView.removeFromSuperview()
            self?.present(nc, animated: false)
        }
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
