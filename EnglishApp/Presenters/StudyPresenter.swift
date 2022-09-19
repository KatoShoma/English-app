//
//  StudyPresenter.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/09/19.
//

import Combine

protocol StudyPresenterProtocol {
    var answerNum: CurrentValueSubject<Int?, Never> { get }
    var wrongAnswer: CurrentValueSubject<[String?], Never> { get }
}

final class StudyPresenter: StudyPresenterProtocol {

    let answerNum: CurrentValueSubject<Int?, Never> = .init(nil)
    let wrongAnswer: CurrentValueSubject<[String?], Never> = .init([nil])

    init() {

    }
    
    func setStudiedData(answerNum: Int, wrongAnswer: [String?]) {
        self.answerNum.value = answerNum
        self.wrongAnswer.value = wrongAnswer
    }
}
