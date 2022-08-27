//
//  RankAlertView.swift
//  EnglishApp
//
//  Created by x21038xx on 2022/08/26.
//

import SwiftUI

struct RankAlertView: View {
    final class Model: ObservableObject {
        // デフォルトは3分に設定
        @Published var time: Int? = 3
    }

    @ObservedObject var model = Model()
    @State private var selection = 2

    let selections: [String] = ["1分", "2分", "3分", "4分", "5分"]
    var body: some View {
        VStack {
            Picker(selection: $selection, label: Text("時間の選択(分)")) {
                ForEach(0..<5) { index in
                    Text(self.selections[index])
                }
            }
            .onChange(of: selection) {newValue in
                model.time = timeStringToNumber(timeString: selections[newValue])
            }
            .labelsHidden()
            .background(Color(UIColor.timerGray))
            .pickerStyle(WheelPickerStyle())
            Spacer()
        }
    }

    func timeStringToNumber(timeString: String) -> Int {
        let time: Int = Int(timeString.prefix(1))!
        return time
    }
}

struct RankAlertView_Previews: PreviewProvider {
    static var previews: some View {
        RankAlertView()
    }
}
