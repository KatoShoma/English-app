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
        Spacer()
        GeometryReader { geometry in
            let height = geometry.size.height
            VStack(alignment: .trailing) {
                (Text(self.model.rank)
                    .font(.system(size: 24))
                    .foregroundColor(Color(UIColor.lightBlack))
                    .padding(EdgeInsets(
                        top: 24,
                        leading: 132,
                        bottom: 24,
                        trailing: 132
                    ))
                )
                .background(Color(self.model.rankColor).cornerRadius(6))
                .frame(maxWidth: .infinity, minHeight: CGFloat(height)/12)
                Button(
                    action: { model.showDetailDataView?() },
                    label: {
                        Text("ランクとは？")
                            .foregroundColor(Color(UIColor.lightBlue))
                            .padding(.trailing, 16)
                    }
                )
            }
        }
    }
}

struct DetailDataView_Previews: PreviewProvider {
    static var previews: some View {
        DetailDataView()
    }
}
