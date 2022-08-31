//
//  View+.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/31.
//

import Foundation
import SwiftUI
import UIKit

extension View {
    func onViewDidLoad(_ perform: @escaping (() -> Void)) -> some View {
        self.modifier(ViewDidLoadModifier(callback: perform))
    }
}

struct ViewDidLoadModifier: ViewModifier {
    let callback: () -> Void

    func body(content: Content) -> some View {
        content.background(ViewDidLoadHandler(onDidLoad: callback))
    }
}

struct ViewDidLoadHandler: UIViewControllerRepresentable {
    func makeCoordinator() -> ViewDidLoadHandler.Coordinator {
        Coordinator(onDidLoad: onDidLoad)
    }

    let onDidLoad: () -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<ViewDidLoadHandler>) -> UIViewController {
        context.coordinator
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ViewDidLoadHandler>) {
    }

    typealias UIViewControllerType = UIViewController

    class Coordinator: UIViewController {
        let onDidLoad: () -> Void

        init(onDidLoad: @escaping () -> Void) {
            self.onDidLoad = onDidLoad
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            onDidLoad()
        }
    }
}
