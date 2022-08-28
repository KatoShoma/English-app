//
//  DataViewController.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/12.
//

import UIKit

class DataViewController: UIViewController {
    private let pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal,
        options: nil
    )

    private let tabView = DataTabView()
    private var viewControllers: [UIViewController] = []

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        let detailDataVC = OutcomeViewController()
        let calenderVC = OutcomeViewController()
        self.viewControllers = [detailDataVC, calenderVC]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "記録"
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .white
        setupHierarchy()
    }

    private func setupHierarchy() {
        view.addSubview(tabView)
        tabView.equalConstraintTo(view, targets: [.leading, .trailing])
        tabView.backgroundColor = .systemBackground
        tabView.onChange = .init { [weak self] selected in
            guard let self = self, let direction = self.direction(nextIndex: selected.rawValue)
            else {
                return
            }
            self.pageViewController.setViewControllers( // 表示するViewControllerの設定
                [self.viewControllers[selected.rawValue]],
                direction: direction,
                animated: true,
                completion: nil
            )
        }

        setupPageViewController()

        NSLayoutConstraint.activate([
            tabView.heightAnchor.constraint(equalToConstant: 60),
            tabView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: tabView.bottomAnchor)
        ])
    }

    private func setupPageViewController() {
        addChild(pageViewController) // DataViewControllerの子要素にpageViewControllerを指定
        view.addSubview(pageViewController.view)
        pageViewController.view.equalConstraintTo(view, targets: [.leading, .trailing, .bottom])
        pageViewController.didMove(toParent: self)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.setViewControllers( // 初期設定
            [viewControllers[0]],
            direction: .forward,
            animated: true,
            completion: nil
        )
    }

    private func direction(nextIndex: Int) -> UIPageViewController.NavigationDirection? {
        guard let currentVC = pageViewController.viewControllers?.first else {
            return nil
        }
        guard let currentIndex = viewControllers.firstIndex(of: currentVC) else {
            return nil
        }
        if currentIndex < nextIndex { // 次のページに
            return .forward
        }
        return .reverse // 前のページに
    }
}

extension DataViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let beforeIndex = currentIndex - 1
        guard beforeIndex >= 0 else {
            return nil
        }
        return viewControllers[beforeIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let afterIndex = currentIndex + 1
        guard afterIndex < viewControllers.count else {
            return nil
        }
        return viewControllers[afterIndex]
    }
}

extension DataViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first else {
            return
        }
        guard let index = viewControllers.firstIndex(of: currentVC) else { return }
        tabView.selectedTab = .init(rawValue: index)!
    }
}
