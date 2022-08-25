//
//  SetTimeView.swift
//  EnglishApp
//
//  Created by x21038xx on 2022/08/24.
//

import SwiftUI

struct SetTimeView: View {
    @State private var selection = 0
    let selections = ["1分", "2分", "3分", "4分", "5分"]
    var body: some View {
        Picker(selection: $selection, label: Text("時間の選択(分)")) {
            ForEach(0..<5) { index in
                Text(self.selections[index])
            }
        }
        .labelsHidden()
        .background(Color(UIColor.timerGray))
        .pickerStyle(WheelPickerStyle())
        Text("\(selection + 1)分")
    }
}

struct SetTimeView_Previews: PreviewProvider {
    static var previews: some View {
        SetTimeView()
    }
}
