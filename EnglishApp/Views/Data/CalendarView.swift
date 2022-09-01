//
//  CalendarView.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/29.
//

import SwiftUI

struct CalendarView: View {
    @State var date = Date()

    var body: some View {
        VStack {
            DatePicker(selection: $date, displayedComponents: .date, label: { Text("日付") })
                .datePickerStyle(GraphicalDatePickerStyle())
            Spacer()
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
