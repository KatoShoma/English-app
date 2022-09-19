//
//  StudyResultView.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/09/19.
//

import SwiftUI

struct StudyResultView: View {
    final class Model: ObservableObject {
        @Published var answerNum: Int?
        @Published var wrongList: [String?] = [""]
    }

    @ObservedObject var model = Model()

    func getAnswerNumLabel() -> String {
        if let answers = model.answerNum {
            return String(answers)
        } else {
            return "---"
        }
    }

    func getAnswerWrongLabel() -> String {
        let wrongs = model.wrongList.count
        return String(wrongs)
    }

    var body: some View {
        Text(getAnswerNumLabel())
        Text(getAnswerWrongLabel())
    }
}

struct StudyResultView_Previews: PreviewProvider {
    static var previews: some View {
        StudyResultView()
    }
}
