//
//  OutcomePresenter.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/24.
//

import Combine

protocol OutcomePresenterProtocol {
    var studyTime: CurrentValueSubject<Int?, Never> { get }
}

final class OutcomePresenter: OutcomePresenterProtocol {

    let studyTime: CurrentValueSubject<Int?, Never> = .init(nil)

    init() {

    }

    func studyTimeDidUpdate(time: Int) {
        studyTime.value = time
    }
}
