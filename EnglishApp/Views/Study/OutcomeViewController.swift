//
//  OutcomeViewController.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/12.
//

import UIKit
import SwiftUI

class OutcomeViewController: UIViewController, UICollectionViewDelegate {
    let presenter: OutcomePresenter
    private let hosting = UIHostingController(rootView: OutcomeView())

    required init?(coder: NSCoder) {
        self.presenter = OutcomePresenter()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "学習"
        setupHierarchy()

        hosting.rootView.model.startLearning = {

        }
        hosting.rootView.model.showTimeSettingView = { [weak self] in
            self?.present(UINavigationController(rootViewController: RankAlertViewController()), animated: true, completion: nil)
        }
    }

    func setupHierarchy() {
        self.addChild(hosting)
        self.view.addSubview(hosting.view)
        hosting.didMove(toParent: self)
        hosting.view.equalConstraintTo(view)
    }
}
