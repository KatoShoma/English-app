//
//  ChoicesButton.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/09/12.
//

import UIKit
import SwiftUI

class ChoicesButton: UIView {

    private let correctionImageView = UIImageView()
    private let titleLabel = UILabel()

    var ward: String? {
        didSet {
            titleLabel.text = ward
        }
    }
    var iconImage: UIImage? {
        didSet {
            correctionImageView.image = iconImage
        }
    }

    var onTap: (() -> Void)?

    public override var intrinsicContentSize: CGSize {
        .init(width: UIView.noIntrinsicMetric, height: 52)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        self.addGestureRecognizer(tapGestureRecognizer)

        setupInternalViews()
    }

    @objc private func didTap() {
        onTap?()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupInternalViews() {
        layer.cornerRadius = 10
        let heightAnchorConst = heightAnchor.constraint(equalToConstant: 52)
        heightAnchorConst.priority = .respectEstimatedDimension
        heightAnchorConst.isActive = true

        addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        titleLabel.equalConstraintTo(self, targets: [.centerX])
        titleLabel.equalConstraintTo(self, targets: [.centerY])

        addSubview(correctionImageView)
        correctionImageView.image = UIImage(named: "ok")
        correctionImageView.contentMode = .scaleAspectFit
        correctionImageView.equalConstraintTo(self, targets: [.centerY])
        correctionImageView.equalConstraintTo(self, constant: 20, targets: [.trailing])
    }
}
