//
//  RankAlertView.swift
//  EnglishApp
//
//  Created by x21038xx on 2022/08/26.
//

import SwiftUI

enum DialogContent: View {
    case contentDetail(isPresented: Binding<Bool>)

    @ViewBuilder
    var body: some View {
        switch self {
        case .contentDetail(let isPresented):
            rankDialogContent(isPresented: isPresented)
        }
    }
}

final class DialogPresentation: ObservableObject {
    @Published var isPresented = false
    @Published var dialogContent: DialogContent?

    func show(content: DialogContent?) {
        if let presentDialog = content {
            dialogContent = presentDialog
            isPresented = true
        } else {
            isPresented = false
        }
    }
}

struct CustomDialog: ViewModifier {
    @ObservedObject var presentationManager: DialogPresentation

    func body(content: Content) -> some View {
        ZStack {
            content
            if presentationManager.isPresented {
                Rectangle().foregroundColor(Color.black.opacity(0.3))
                    .edgesIgnoringSafeArea(.all)
                presentationManager.dialogContent
                    .padding(32)
            }
        }
    }
}

extension View {
    func customDialog(
        presentationManager: DialogPresentation
    ) -> some View {
        self.modifier(CustomDialog(presentationManager: presentationManager))
    }
}

#if DEBUG

struct RankAlertView: View {
    @State private var dialogPresentataion = DialogPresentation()

    var body: some View {
        VStack {
            Text("Demo")
                .padding()
            Button(action: {
                dialogPresentataion.show(content: .contentDetail(isPresented: $dialogPresentataion.isPresented))}){
                    Text("Present dialog")
                        .autocapitalization(.allCharacters)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .padding()
        }
        .customDialog(presentationManager: dialogPresentataion)
    }
}

struct rankDialogContent: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("ランクについて")
                .font(.title3)
            Text("ランクは1分間の最高正答数で決定します")
                .font(.caption2)
                .padding()
                .foregroundColor(Color(UIColor.lightBlack))
            (Text("ゴールド")
                .foregroundColor(Color(UIColor.gold))
            + Text("       正答数:〇〇以上")
                .foregroundColor(Color(UIColor.lightBlack)))
                    .font(.subheadline)
                    .padding()
            (Text("シルバー")
                .foregroundColor(Color(UIColor.silver))
            + Text("       正答数:〇〇〜〇〇")
                .foregroundColor(Color(UIColor.lightBlack)))
                    .font(.subheadline)
                    .padding()
            (Text("ブロンズ")
                .foregroundColor(Color(UIColor.bronze))
            + Text("       正答数:〇〇以下")
                .foregroundColor(Color(UIColor.lightBlack)))
                    .font(.subheadline)
                    .padding()
            Button(action: {isPresented = false}) {
                Text("Close Dialog")
                    .padding()
            }
        }
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct CustomDialog_Previews: PreviewProvider {
    static var previews: some View {
        RankAlertView()
            .environment(\.colorScheme, .light)
    }
}
#endif
