//
//  SUChoicesButton.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/09/12.
//

import SwiftUI

struct SUChoicesButton: UIViewRepresentable {
    var ward: String = ""
    var iconImage: UIImage?

    var onTap: (() -> Void)?

    func makeUIView(context: Context) -> ChoicesButton {
        let v = ChoicesButton()
        return v
    }

    func updateUIView(_ uiView: ChoicesButton, context: Context) {
        uiView.ward = ward
        uiView.iconImage = iconImage
        uiView.onTap = onTap
    }
}
