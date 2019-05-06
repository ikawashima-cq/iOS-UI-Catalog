//
//  PresentationViewController.swift
//  UI-Catalog
//
//  Created by Iichiro Kawashima on 2019/05/05.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import UIKit
import RxSwift

// 遷移元のViewController
class PresentingViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!

    private let disposeBag: DisposeBag = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        button.rx.tap
            .subscribe(onNext: { [unowned self] in
                let vc: UIViewController! = self.storyboard?.instantiateViewController(withIdentifier: PresentedViewController.className) as! UIViewController
                vc.modalPresentationStyle = .custom
                vc.transitioningDelegate = self
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
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

extension PresentingViewController: UIViewControllerTransitioningDelegate {
    // presented 現在後のVC
    // presenting 遷移前のVC
    // 遷移のライフサイクルやレイアウトを制御するため、CustomPresentationControllerを挟む
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
