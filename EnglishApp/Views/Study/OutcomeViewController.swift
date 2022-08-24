//
//  OutcomeViewController.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/12.
//

import UIKit
import SwiftUI

class OutcomeViewController: UIViewController, UICollectionViewDelegate {

    private let hosting = UIHostingController(rootView: OutcomeView())

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "学習"
        setupHierarchy()

        hosting.rootView.model.startLearning = {
            // NOTE: 関数の中身を記載
        }
        hosting.rootView.model.showTimeSettingView = {
            // NOTE: 関数の中身を記載
        }
    }

    func setupHierarchy() {
        self.addChild(hosting)
        self.view.addSubview(hosting.view)
        hosting.didMove(toParent: self)
        hosting.view.equalConstraintTo(view)
    }
}
