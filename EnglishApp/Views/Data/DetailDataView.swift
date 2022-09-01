//
//  DetailDataView.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/29.
//

import SwiftUI

struct DetailDataView: View {
    final class Model: ObservableObject {
        @Published var rank: String?
        @Published var rankColor: Color?
        @Published var weakWord: [String]?
    }

    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            VStack {
                (Text("ランク")
                    .font(.system(size: 24))
                    .foregroundColor(Color(UIColor.lightBlack))
                    .padding(EdgeInsets(
                        top: 24,
                        leading: 146,
                        bottom: 24,
                        trailing: 146
                    ))
                )
                .background(Color(UIColor.gold).cornerRadius(6))
                .frame(maxWidth: .infinity, minHeight: CGFloat(height)/12)
            }
            Spacer()
        }
    }
}

struct DetailDataView_Previews: PreviewProvider {
    static var previews: some View {
        DetailDataView()
    }
}
