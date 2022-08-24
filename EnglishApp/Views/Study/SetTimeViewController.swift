//
//  SetTimeViewController.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/24.
//

import UIKit
import SwiftUI

class SetTimeViewController: UIViewController {
    required init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        let hosting = UIHostingController(rootView: OutcomeView())
        addChild(hosting)
        view.addSubview(hosting.view)
        hosting.didMove(toParent: self)
        hosting.view.equalConstraintTo(view)
        title = "時間の設定"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
