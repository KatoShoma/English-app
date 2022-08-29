//
//  CalendarViewController.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/29.
//

import UIKit
import SwiftUI

class CalendarViewController: UIViewController {
    let hosting = UIHostingController(rootView: CalendarView())

    required init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        addChild(hosting)
        view.addSubview(hosting.view)
        hosting.didMove(toParent: self)
        hosting.view.equalConstraintTo(view)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
