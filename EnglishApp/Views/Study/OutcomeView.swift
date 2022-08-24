//
//  OutcomeView.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/23.
//

import SwiftUI

struct OutcomeView: View {
    final class Model: ObservableObject {
        @Published var studyTime: Int?
        var startLearning: (() -> Void)?
        var showTimeSettingView: (() -> Void)?
    }

    @ObservedObject var model = Model()

    func getTimeLabel() -> String {
        if let time = model.studyTime {
            return String(time) + "分"
        } else {
            return "---"
        }
    }

    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height

            VStack(spacing: 0) {
                Spacer()
                Button(
                    action: { model.startLearning?() },
                    label: {
                        VStack {
                            Text("")
                            Text("学習開始")
                                .font(.title)
                                .foregroundColor(Color.white)
                            Spacer()
                                .frame(height: 5)
                            HStack {
                                Group {
                                    Text("時間:")
                                    Text(getTimeLabel())
                                }
                                .foregroundColor(Color.white)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: CGFloat(height)/12 * 2)
                        .background(Color(UIColor.startOrange))
                        .cornerRadius(6)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 12)
                    }
                )
                Button(
                    action: { model.showTimeSettingView?() },
                    label: {
                        Text("時間の設定")
                            .foregroundColor(Color(UIColor.lightBlack))
                            .frame(maxWidth: .infinity, minHeight: CGFloat(height)/12)
                            .background(Color(UIColor.timerBlue))
                            .cornerRadius(6)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 12)
                    }
                )
            }
        }
    }
}

struct OutcomeView_Previews: PreviewProvider {
    static var previews: some View {
        OutcomeView()
    }
}
