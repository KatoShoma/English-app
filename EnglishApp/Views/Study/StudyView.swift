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
        var studied: (() -> Void)?
    }

    @ObservedObject var model = Model()
    @ObservedObject var timerManager = TimerManager()

    var body: some View {
        VStack {
            Text(timerManager.timeLabel)
                .font(.system(size: 50))
                .onViewDidLoad {
                    guard let time = model.times else { return }
                    self.timerManager.start(studyTime: time)
                }
                .onChange(of: timerManager.time) { value in
                    if value == 0 {
                        model.studied?()
                    }
                }
        }
    }
}

struct StudyView_Previews: PreviewProvider {
    static var previews: some View {
        StudyView()
    }
}
