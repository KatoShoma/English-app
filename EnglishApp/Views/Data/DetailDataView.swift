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
        @Published var weakWord: [String] = ["Happy", "Sad", "Smile"]
        @Published var num: Int = 5
        var showDetailDataView: (() -> Void)?
    }

    @ObservedObject var model = Model()

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
            VStack(spacing: 24) {
                Spacer().frame(height: 6)
                HStack {
                    Text("1")
                        .font(.system(size: 20))
                        .foregroundColor(Color(UIColor.lightBlack))
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(Color(UIColor.rankCream).cornerRadius(25))
                        .clipShape(Circle())
                    Text(self.model.weakWord[0])
                        .font(.system(size: 24))
                        .foregroundColor(Color(UIColor.lightBlack))
                        .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                }
                HStack {
                    Text("2")
                        .font(.system(size: 20))
                        .foregroundColor(Color(UIColor.lightBlack))
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(Color(UIColor.rankCream).cornerRadius(25))
                        .clipShape(Circle())
                    Text(self.model.weakWord[1])
                        .font(.system(size: 24))
                        .foregroundColor(Color(UIColor.lightBlack))
                        .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                }
                HStack {
                    Text("3")
                        .font(.system(size: 20))
                        .foregroundColor(Color(UIColor.lightBlack))
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(Color(UIColor.rankCream).cornerRadius(25))
                        .clipShape(Circle())
                    Text(self.model.weakWord[2])
                        .font(.system(size: 24))
                        .foregroundColor(Color(UIColor.lightBlack))
                        .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                }
            }
            /*HStack {
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
                    Text(self.model.weakWord[0])
                        .font(.system(size: 24))
                        .foregroundColor(Color(UIColor.lightBlack))
                        .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                    Text(self.model.weakWord[1])
                        .font(.system(size: 24))
                        .foregroundColor(Color(UIColor.lightBlack))
                        .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                    Text(self.model.weakWord[2])
                        .font(.system(size: 24))
                        .foregroundColor(Color(UIColor.lightBlack))
                        .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                }
            }*/
            Spacer().frame(height: 48)
            Text("最高正解数")
                .foregroundColor(Color(UIColor.lightBlack))
                .font(.system(size: 16))
            Divider()
            Text("\(self.model.num)問")
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
