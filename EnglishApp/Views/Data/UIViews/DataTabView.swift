//
//  DataTabView.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/28.
//

import UIKit
import SwiftUI

final class DataTabView: UIView {
    enum Tab: Int {
        case detailData, calendar
    }

    var selectedTab = Tab.detailData {
        didSet {
            configureViews()
            if oldValue != selectedTab {
                onChange?(selectedTab)
            }
        }
    }

    var onChange: ((Tab) -> Void)?

    fileprivate let detailDataView = DataTabContentView()
    fileprivate let calendarView = DataTabContentView()
    private var underBarTrailingConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupHierarchy()
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        addSubview(detailDataView)
        detailDataView.equalConstraintTo(self, targets: [.top, .leading, .bottom])
        detailDataView.title = "詳細データ"
        detailDataView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(detailDataViewDidTap(_:)))
        )

        addSubview(calendarView)
        calendarView.equalConstraintTo(self, targets: [.top, .trailing, .bottom])
        calendarView.title = "日別カレンダー"
        calendarView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(calendarViewDidTap(_:)))
        )

        NSLayoutConstraint.activate([
            detailDataView.trailingAnchor.constraint(equalTo: calendarView.leadingAnchor),
            detailDataView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])

        // 区切り線
        let separator = UIView()
        separator.heightAnchor.constraint(equalToConstant: .separatorPixel).isActive = true
        separator.backgroundColor = .lightGray
        addSubview(separator)
        separator.equalConstraintTo(self, targets: [.leading, .bottom, .trailing])

        // 選択時の下線
        let underBar = UIView()
        addSubview(underBar)
        underBar.equalConstraintTo(self, targets: [.bottom])
        underBar.backgroundColor = .pastelRed
        let underBarLeading = underBar.leadingAnchor.constraint(equalTo: leadingAnchor)
        underBarLeading.isActive = true
        underBarLeading.priority = .defaultLow
        underBarTrailingConstraint = underBar.trailingAnchor.constraint(equalTo: trailingAnchor) // 右寄せの場合
        underBarTrailingConstraint?.priority = .defaultHigh
        NSLayoutConstraint.activate([
            underBar.heightAnchor.constraint(equalToConstant: 2),
            underBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5) // 幅
        ])
    }

    private func configureViews() {
        UIView.animate(withDuration: 0.3) {
            switch self.selectedTab {
            case .detailData:
                self.detailDataView.isSelected = true
                self.calendarView.isSelected = false
                self.underBarTrailingConstraint?.isActive = false
            case .calendar:
                self.detailDataView.isSelected = false
                self.calendarView.isSelected = true
                self.underBarTrailingConstraint?.isActive = true
            }
        }
    }

    @objc func detailDataViewDidTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            selectedTab = .detailData
        }
    }

    @objc func calendarViewDidTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            selectedTab = .calendar
        }
    }
}
