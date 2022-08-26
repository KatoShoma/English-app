//
//  SetTimeViewController.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/24.
//

import UIKit
import SwiftUI

class SetTimeViewController: UIViewController {
    let hosting = UIHostingController(rootView: SetTimeView())

    required init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        addChild(hosting)
        view.addSubview(hosting.view)
        hosting.didMove(toParent: self)
        hosting.view.equalConstraintTo(view)
        title = "時間の設定"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // キャンセル・保存ボタン
    override func viewDidLoad() {
        super.viewDidLoad()
        var cancelButtonItem: UIBarButtonItem! // キャンセルボタン
        var preservationButtonItem: UIBarButtonItem! // 保存ボタン

        cancelButtonItem = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(cancelButtonPressed(_:)))
        preservationButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(preservationButtonPressed(_:)))

        cancelButtonItem.tintColor = UIColor.lightBlue
        preservationButtonItem.tintColor = UIColor.lightBlue

        self.navigationItem.leftBarButtonItem = cancelButtonItem
        self.navigationItem.rightBarButtonItem = preservationButtonItem
    }

    @objc func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func preservationButtonPressed(_ sender: UIBarButtonItem) {
        if let studyTime = self.hosting.rootView.model.time {
            print(studyTime)
        } else {
            print("---")
        }
    }
}
