//
//  SettingPresenter.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/12.
//

import Foundation
import Combine

protocol SettingPresenterProtocol {

    var versionNumber: String { get }

    func reviewDidTap()
    func shareDidTap()
    func hintDidTap()
}

final class SettingPresenter: SettingPresenterProtocol {
    var versionNumber: String {
        return "1.0.0" // NOTE: 後々，自動取得にする
    }

    init() {
    }

    func reviewDidTap() {
        print("review")
    }

    func shareDidTap() {
        print("share")
    }

    func hintDidTap() {
        print("hint")
    }

}
