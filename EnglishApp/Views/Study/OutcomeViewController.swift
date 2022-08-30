//
//  OutcomeViewController.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/12.
//

import UIKit
import SwiftUI
import Combine

class OutcomeViewController: UIViewController, UICollectionViewDelegate {
    let presenter: OutcomePresenter
    private let hosting = UIHostingController(rootView: OutcomeView())
    private var cancellables: Set<AnyCancellable> = []

    required init?(coder: NSCoder) {
        self.presenter = OutcomePresenter()
        super.init(coder: coder)
    }

    init() {
        self.presenter = OutcomePresenter()
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "学習"
        setupHierarchy()

        let studyVC = UINavigationController(rootViewController: StudyViewController())
        studyVC.modalPresentationStyle = .fullScreen
        hosting.rootView.model.startLearning = { [weak self] in
            self?.present(studyVC, animated: false, completion: nil)
        }
        hosting.rootView.model.showTimeSettingView = { [weak self] in
            self?.present(UINavigationController(rootViewController: SetTimeViewController(onChangeStudyTime: { [weak self] studyTime in
                guard let self = self else { return }
                self.presenter.studyTimeDidUpdate(time: studyTime)
            })), animated: true, completion: nil)
        }
        subscribePresenterSubjects()
    }

    func setupHierarchy() {
        self.addChild(hosting)
        self.view.addSubview(hosting.view)
        hosting.didMove(toParent: self)
        hosting.view.equalConstraintTo(view)
    }

    private func subscribePresenterSubjects() {
        presenter.studyTime
            .sink { [weak self] setTime in
                self?.hosting.rootView.model.studyTime = setTime
            }
            .store(in: &cancellables)
    }
}
