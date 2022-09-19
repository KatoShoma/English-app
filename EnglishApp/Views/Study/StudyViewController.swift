//
//  StudyViewController.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/30.
//

import UIKit
import SwiftUI

class StudyViewController: UIViewController {

    let presenter: StudyPresenter
    let hosting = UIHostingController(rootView: StudyView())

    required init?(coder: NSCoder) {
        self.presenter = StudyPresenter()
        super.init(coder: coder)
    }

    init(studyMinute: Int) {
        self.presenter = StudyPresenter()
        hosting.rootView.model.times = studyMinute * 60
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupNavigationBar()

        hosting.rootView.model.studied = { [weak self] in
            guard let self = self else { return }
            // Presenterで画面遷移のロジックを定義
            let answerNum = self.hosting.rootView.model.correctNum
            let wrongAnswers = self.hosting.rootView.model.wrongList
            let resultVC = UINavigationController(rootViewController: StudyResultViewController(answerNumber: answerNum, wrongList: wrongAnswers))
            resultVC.modalPresentationStyle = .fullScreen
            self.present(resultVC, animated: false, completion: nil)
        }

        hosting.rootView.onTap = { [weak self] answer, response in
            guard let self = self else { return true }
            if answer == response {
                print("正解")
                return true
            } else {
                print("不正解")
                return false
            }
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
