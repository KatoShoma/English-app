//
//  StudyViewController.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/30.
//

import UIKit
import SwiftUI

class StudyViewController: UIViewController {

    let hosting = UIHostingController(rootView: StudyView())

    required init(studyMinute: Int) {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        hosting.rootView.model.times = studyMinute * 60
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupNavigationBar()

        hosting.rootView.model.studied = {
            // Presenterで画面遷移のロジックを定義
        }
    }

    func setupHierarchy() {
        self.addChild(hosting)
        self.view.addSubview(hosting.view)
        hosting.didMove(toParent: self)
        hosting.view.equalConstraintTo(view)
    }

    func setupNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.shadowColor = .clear
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}
