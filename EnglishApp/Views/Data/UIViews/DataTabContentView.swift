//
//  DataTabContentView.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/28.
//

import UIKit
import SwiftUI

final class DataTabContentView: UIView {
    var title = "" {
        didSet { // 変数の値が変更された後に処理を行う
            configureViews()
        }
    }

    var isSelected = false {
        didSet {
            configureViews()
        }
    }

    fileprivate let titleView = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        let stackView = UIStackView(
            arrangedSubviews: [UIView(), titleView, UIView()]
        )
        addSubview(stackView)
        stackView.equalConstraintTo(self)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 4

        titleView.textAlignment = .center
    }

    private func configureViews() {
        titleView.text = title

        if isSelected {
            titleView.font = .boldSystemFont(ofSize: 15)
            titleView.textColor = .lightBlack
        } else {
            titleView.font = .systemFont(ofSize: 15)
            titleView.textColor = .gray
        }
    }
}
