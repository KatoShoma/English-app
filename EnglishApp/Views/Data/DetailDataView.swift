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
        @Published var weakWord: [String]?
        var showDetailDataView: (() -> Void)?
    }

    @ObservedObject var model = Model()

    var body: some View {
        VStack {
            Text(self.model.rank)
                .font(.system(size: 20))
                .foregroundColor(Color(UIColor.lightBlack))
                .frame(maxWidth: .infinity, minHeight: 72)
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
        }
        Spacer()
    }
}

struct DetailDataView_Previews: PreviewProvider {
    static var previews: some View {
        DetailDataView()
    }
}
