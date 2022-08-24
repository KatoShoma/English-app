//
//  UIView+NSLayoutConstraint.swift
//  ZSTAFF
//

import UIKit

extension UIView {
    enum Anchor {
        case top, leading, trailing, bottom, centerX, centerY
    }

    func equalConstraintTo(
        _ layoutGuide: UILayoutGuide,
        constant: CGFloat = 0,
        targets: Set<Anchor> = [.top, .leading, .trailing, .bottom],
        priority: UILayoutPriority = .required
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        targets.forEach { anchor in
            switch anchor {
            case .top:
                let top = topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: constant)
                top.priority = priority
                top.isActive = true
            case .leading:
                let leading = leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: constant)
                leading.priority = priority
                leading.isActive = true
            case .trailing:
                let trailing = trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -constant)
                trailing.priority = priority
                trailing.isActive = true
            case .bottom:
                let bottom = bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -constant)
                bottom.priority = priority
                bottom.isActive = true
            case .centerX:
                let centerX = centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor, constant: constant)
                centerX.priority = priority
                centerX.isActive = true
            case .centerY:
                let centerY = centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor, constant: constant)
                centerY.priority = priority
                centerY.isActive = true
            }
        }
    }

    func equalConstraintTo(
        _ view: UIView,
        constant: CGFloat = 0,
        targets: Set<Anchor> = [.top, .leading, .trailing, .bottom],
        priority: UILayoutPriority = .required
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        targets.forEach { anchor in
            switch anchor {
            case .top:
                let top = topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
                top.priority = priority
                top.isActive = true
            case .leading:
                let leading = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
                leading.priority = priority
                leading.isActive = true
            case .trailing:
                let trailing = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant)
                trailing.priority = priority
                trailing.isActive = true
            case .bottom:
                let bottom = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
                bottom.priority = priority
                bottom.isActive = true
            case .centerX:
                let centerX = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
                centerX.priority = priority
                centerX.isActive = true
            case .centerY:
                let centerY = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
                centerY.priority = priority
                centerY.isActive = true
            }
        }
    }
}
