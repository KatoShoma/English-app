//
//  SettingPresenter.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/12.
//

import Foundation
import Combine
import UIKit

protocol SettingPresenterProtocol {
    var onOpenURL: PassthroughSubject<URL, Never> { get }
    var onOpenShareURL: PassthroughSubject<URL, Never> { get }
    var versionNumber: String { get }

    func reviewDidTap()
    func shareDidTap()
    func hintDidTap()
}

final class SettingPresenter: SettingPresenterProtocol {
    let onOpenURL: PassthroughSubject<URL, Never> = .init()
    let onOpenShareURL: PassthroughSubject<URL, Never> = .init()
    var versionNumber: String {
        return "1.0.0" // NOTE: 後々，自動取得にする
    }

    init() {
    }

    func reviewDidTap() {
        onOpenURL.send(.testURL)
    }

    func shareDidTap() {
        // NOTE: LINEとTwitterは共有できない→修正するか迷い中
        onOpenShareURL.send(.testURL)
    }

    func hintDidTap() {
        print("hint")
    }

}
