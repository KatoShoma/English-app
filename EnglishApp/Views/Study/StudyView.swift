//
//  StudyView.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/30.
//

import SwiftUI

struct StudyView: View {
    final class Model: ObservableObject {
        @Published var times: Int?
        @Published var images = [UIImage?](repeating: nil, count: 4)
        @Published var options = [String](repeating: "", count: 4)
        @Published var frameColor = [UIColor](repeating: UIColor.lightBlack, count: 4)
        @Published var answerIndex: Int = 0
        @Published var answer: String = ""
        @Published var issueData = [Issue]()
        @Published var issueIndex: Int = 0
        @Published var issueWard: String = ""
        @Published var correctNum: Int = 0
        @Published var wrongList: [String?] = []
        var studied: (() -> Void)?
    }

    @ObservedObject var model = Model()
    @ObservedObject var timerManager = TimerManager()

    // NOTE: ターゲットの問題が入る
    @State private var issue: Issue?

    enum resultType {
        case correct,
             incorrect

        var icon: UIImage? {
            switch self {
            case .correct: return .init(named: "ok")
            case .incorrect: return .init(named: "ng")
            }
        }
    }

    private let deviceHeight: CGFloat = UIScreen.main.bounds.height
    private let deviceWidth: CGFloat = UIScreen.main.bounds.width
    private let imageHeight: CGFloat

    init() {
        imageHeight = deviceHeight * 0.35
        model.issueData.append(Issue(ward: "happy", answer: "幸せ", option1: "幸せ", option2: "悲しみ", option3: "怒り", option4: "怠惰"))
        model.issueData.append(Issue(ward: "happy", answer: "幸せ", option1: "悲しみ", option2: "幸せ", option3: "怒り", option4: "怠惰"))
        setWard(index: model.issueIndex)
    }

    var onTap: ((String, String) -> Bool)?

    var body: some View {
        VStack {
            Spacer()
            Image("noodle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imageHeight)
                .padding(.bottom, 12)
                .overlay(
                    Text(timerManager.timeLabel)
                        .font(.system(size: 40))
                        .frame(width: deviceWidth * 0.5, height: 50)
                        .offset(x: 0, y: 0 - imageHeight * 0.35)
                        .onViewDidLoad { // スタート
                            guard let time = model.times else { return }
                            self.timerManager.start(studyTime: time)
                        }
                        .onChange(of: timerManager.time) { value in
                            if value == 0 { // 修了処理
                                model.studied?()
                            }
                        }
                )
                .overlay(
                    Text(model.issueWard)
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.3)
                        .frame(width: deviceWidth * 0.35, height: 50)
                        .offset(x: 0, y: imageHeight * 0.13)
                )

            SUChoicesButton(
                ward: model.options[0],
                iconImage: model.images[0]
            ) {
                guard let result = onTap?(model.answer, model.options[0]) else { return }
                if result { // 正解した場合の処理
                    model.images[0] = resultType.correct.icon
                    model.frameColor[0] = UIColor.pastelRed
                    model.correctNum += 1
                } else { // 間違えた場合の処理
                    model.images[0] = resultType.incorrect.icon
                    model.wrongList.append(model.issueWard)
                    model.images[model.answerIndex] = resultType.correct.icon
                    model.frameColor[model.answerIndex] = UIColor.pastelRed
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    if model.issueData.count - 1 == model.issueIndex {
                        model.issueIndex = 0
                    } else {
                        model.issueIndex += 1
                    }
                    setWard(index: model.issueIndex)
                }
            }
            .frame(width: self.deviceWidth * 0.8, height: 44)
            .background(Color(UIColor.white))
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color(model.frameColor[0]), lineWidth: 5)
            )
            .padding(.bottom, 6)

            SUChoicesButton(
                ward: model.options[1],
                iconImage: model.images[1]
            ) {
                guard let result = onTap?(model.answer, model.options[1]) else { return }
                if result {
                    model.images[1] = resultType.correct.icon
                    model.frameColor[1] = UIColor.pastelRed
                    model.correctNum += 1
                } else {
                    model.images[1] = resultType.incorrect.icon
                    model.wrongList.append(model.issueWard)
                    model.images[model.answerIndex] = resultType.correct.icon
                    model.frameColor[model.answerIndex] = UIColor.pastelRed
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    if model.issueData.count - 1 == model.issueIndex {
                        model.issueIndex = 0
                    } else {
                        model.issueIndex += 1
                    }
                    setWard(index: model.issueIndex)
                }
            }
            .frame(width: self.deviceWidth * 0.8, height: 44)
            .background(Color(UIColor.white))
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color(model.frameColor[1]), lineWidth: 5)
            )
            .padding(.bottom, 6)

            SUChoicesButton(
                ward: model.options[2],
                iconImage: model.images[2]
            ) {
                guard let result = onTap?(model.answer, model.options[2]) else { return }
                if result {
                    model.images[2] = resultType.correct.icon
                    model.frameColor[2] = UIColor.pastelRed
                    model.correctNum += 1
                } else {
                    model.images[2] = resultType.incorrect.icon
                    model.wrongList.append(model.issueWard)
                    model.images[model.answerIndex] = resultType.correct.icon
                    model.frameColor[model.answerIndex] = UIColor.pastelRed
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    if model.issueData.count - 1 == model.issueIndex {
                        model.issueIndex = 0
                    } else {
                        model.issueIndex += 1
                    }
                    setWard(index: model.issueIndex)
                }
            }
            .frame(width: self.deviceWidth * 0.8, height: 44)
            .background(Color(UIColor.white))
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color(model.frameColor[2]), lineWidth: 5)
            )
            .padding(.bottom, 6)

            SUChoicesButton(
                ward: model.options[3],
                iconImage: model.images[3]
            ) {
                guard let result = onTap?(model.answer, model.options[3]) else { return }
                if result {
                    model.images[3] = resultType.correct.icon
                    model.frameColor[3] = UIColor.pastelRed
                    model.correctNum += 1
                } else {
                    model.images[3] = resultType.incorrect.icon
                    model.wrongList.append(model.issueWard)
                    model.images[model.answerIndex] = resultType.correct.icon
                    model.frameColor[model.answerIndex] = UIColor.pastelRed
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    if model.issueData.count - 1 == model.issueIndex {
                        model.issueIndex = 0
                    } else {
                        model.issueIndex += 1
                    }
                    setWard(index: model.issueIndex)
                }
            }
            .frame(width: self.deviceWidth * 0.8, height: 44)
            .background(Color(UIColor.white))
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color(model.frameColor[3]), lineWidth: 5)
            )
            .padding(.bottom, 6)
        }
    }

    func setWard(index: Int) {
        // NOTE: 問題のデータセットからindexを参照して問題を抽出
        let issue = model.issueData[index]
        let options = [issue.option1, issue.option2, issue.option3, issue.option4]
        model.images = [UIImage?](repeating: nil, count: 4)
        model.issueWard = issue.ward
        model.frameColor = [UIColor](repeating: UIColor.lightBlack, count: 4)
        model.options[0] = issue.option1
        model.options[1] = issue.option2
        model.options[2] = issue.option3
        model.options[3] = issue.option4
        model.answer = issue.answer
        model.answerIndex = setAnswerIndex(answer: model.answer, options: options)
    }

    func setAnswerIndex(answer: String, options: [String]) -> Int {
        for( idx, value ) in options.enumerated() where value == answer {
            return idx
        }
        return -1
    }

}

struct StudyView_Previews: PreviewProvider {
    static var previews: some View {
        StudyView()
    }
}
