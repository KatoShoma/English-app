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
        let hosting = UIHostingController(rootView: SetTimeView())
        addChild(hosting)
        view.addSubview(hosting.view)
        hosting.didMove(toParent: self)
        hosting.view.equalConstraintTo(view)
        title = "時間の設定"
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
        print("追加ボタンが押されました")
    }

    @objc func preservationButtonPressed(_ sender: UIBarButtonItem) {
        print("削除ボタンが押されました")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
