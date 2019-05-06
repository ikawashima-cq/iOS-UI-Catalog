//
//  PresentedViewController.swift
//  UI-Catalog
//
//  Created by Iichiro Kawashima on 2019/05/06.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import UIKit
import RxSwift
// 遷移先のViewController
class PresentedViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var button: UIButton! {
        didSet {
            button.setTitle("close", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .lightGray
            button.layer.cornerRadius = 5.0
        }
    }

    private let disposebag: DisposeBag = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.bringSubviewToFront(button)
        
        button.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.dismiss(animated: true)
            }).disposed(by: disposebag)
        // Do any additional setup after loading the view.
    }

}
