//
//  DetailDataView.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/29.
//

import SwiftUI

struct DetailDataView: View {
    final class Model: ObservableObject {
        @Published var rank: String = "ブロンズ"
        @Published var rankColor: UIColor = .bronze
        @Published var weakWords: [String?] = [nil, nil, nil]
        @Published var bestCorrectAnswer: Int?
        var showDetailDataView: (() -> Void)?
    }

    @ObservedObject var model = Model()

    func getweakWord(index: Int) -> String {
        if let weakWord = model.weakWords[index] {
            return weakWord
        } else {
            return "---"
        }
    }

    func getCorrectAnswer() -> Int {
        if let correctAnswer = model.bestCorrectAnswer {
            return Int(correctAnswer)
        } else {
            return 0
        }
    }

    var body: some View {
        VStack {
            Text(self.model.rank)
                .font(.system(size: 20))
                .foregroundColor(Color(UIColor.lightBlack))
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(Color(self.model.rankColor).cornerRadius(6))
                .padding(.horizontal, 12)
                .padding(.top, 12)
            Button(
                action: { model.showDetailDataView?() },
                label: {
                    Text("ランクとは？")
                        .foregroundColor(Color(UIColor.lightBlue))
                        .padding(.trailing, 16)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            )
            Spacer().frame(height: 48)
            Text("苦手単語")
                .foregroundColor(Color(UIColor.lightBlack))
                .font(.system(size: 16))
            Divider()
            HStack {
                VStack(spacing: 24) {
                    Spacer().frame(height: 6)
                    Text("1")
                        .font(.system(size: 20))
                        .foregroundColor(Color(UIColor.lightBlack))
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(Color(UIColor.rankCream).cornerRadius(25))
                        .clipShape(Circle())
                    Text("2")
                        .font(.system(size: 20))
                        .foregroundColor(Color(UIColor.lightBlack))
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(Color(UIColor.rankCream).cornerRadius(25))
                        .clipShape(Circle())
                    Text("3")
                        .font(.system(size: 20))
                        .foregroundColor(Color(UIColor.lightBlack))
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(Color(UIColor.rankCream).cornerRadius(25))
                        .clipShape(Circle())
                }
                VStack(spacing: 24) {
                    Spacer().frame(height: 6)
                    Text(getweakWord(index: 0))
                        .font(.system(size: 24))
                        .foregroundColor(Color(UIColor.lightBlack))
                        .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                    Text(getweakWord(index: 1))
                        .font(.system(size: 24))
                        .foregroundColor(Color(UIColor.lightBlack))
                        .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                    Text(getweakWord(index: 2))
                        .font(.system(size: 24))
                        .foregroundColor(Color(UIColor.lightBlack))
                        .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                }
            }
            Spacer().frame(height: 48)
            Text("最高正解数")
                .foregroundColor(Color(UIColor.lightBlack))
                .font(.system(size: 16))
            Divider()
            Text("\(getCorrectAnswer())問")
                .font(.system(size: 24))
                .foregroundColor(Color(UIColor.lightBlack))
        }
        Spacer()
    }
}

struct DetailDataView_Previews: PreviewProvider {
    static var previews: some View {
        DetailDataView()
    }
}
