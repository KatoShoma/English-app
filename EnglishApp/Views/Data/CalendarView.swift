//
//  CalendarView.swift
//  EnglishApp
//
//  Created by 加藤祥真 on 2022/08/29.
//

import SwiftUI

struct CalendarView: View {
    class CalendarDay: UIResponder, UIApplicationDelegate {
        let year: Int = Calendar.current.component(.year, from: Date())
        let month: Int = Calendar.current.component(.month, from: Date())
    }

    @State var year: Int = CalendarDay().year
    @State var month: Int = CalendarDay().month

    let dayofweek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var body: some View {
        VStack {
            Text("\(String(self.year))/\(self.month)")
                .font(.system(size: 20))
            HStack {
                ForEach(0..<7) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                            .foregroundColor(Color.clear)
                        Text(dayofweek[index])
                            .font(.system(size: 10))
                    }
                }
            }
            CalendarList(year: $year, month: $month, week: GetWeekNumber(year: self.year, month: self.month), start: DayofWeekCalc(year: self.year, month: self.month, day: 1), days: DayNumber(year: self.year, month: self.month))
            HStack {
                Button(action: {
                    self.LastMonth()
                }, label: {
                    Text("＜ 先月")
                        .padding(.trailing, 100)
                })
                Button(action: {
                    self.NextMonth()
                }, label: {
                    Text("来月 ＞")
                        .padding(.leading, 100)
                })
            }
        }
        .padding(.top, 32)
        Spacer()
    }

    func NextMonth() {
        if self.month != 12 {
            self.month += 1
        } else if self.month == 12 {
            self.year += 1
            self.month = 1
        }
    }

    func LastMonth() {
        if self.month != 1 {
            self.month -= 1
        } else if self.month == 1 {
            self.year -= 1
            self.month = 12
        }
    }
}

func LeapYear(year: Int) -> Bool {
    let result =  (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0 )) ? true : false
    return result
}

func DayofWeekCalc(year: Int, month: Int, day: Int) -> Int {
    var result: Int = 0
    if month == 1 || month ==  2 {
        var changeyear: Int = year
        var changemonth: Int = month
        changeyear -= 1
        changemonth += 12
        result  = (day + (26 * (changemonth + 1))/10 + changeyear + (changeyear / 4) + (5 * (changeyear / 100)) + ((changeyear / 100)/4) + 5) % 7 as Int
    } else {
        result  = (day + (26 * (month + 1))/10 + year + (year / 4) + (5 * (year / 100)) + ((year / 100)/4) + 5) % 7 as Int
    }
    return result
}

func GetWeekNumber(year: Int, month: Int) -> Int {
    var result: Int = 0
    if CaseFourWeek(year: year, month: month) {
        result = 4
    } else if CaseSixWeek(year: year, month: month) {
        result = 6
    } else {
        result = 5
    }
    return result
}

private func CaseFourWeek(year: Int, month: Int) -> Bool {
    let firstdayofweek = DayofWeekCalc(year: year, month: month, day: 1)
    let result = (!LeapYear(year: year) && month == 2 && (firstdayofweek == 0)) ? true : false
    return result
}

private func CaseSixWeek(year: Int, month: Int) -> Bool {
    let firstdayofweek = DayofWeekCalc(year: year, month: month, day: 1)
    let days = DayNumber(year: year, month: month)
    let result = ((firstdayofweek == 6 && days == 30) || (firstdayofweek >= 5 && days == 31)) ? true : false
    return result
}

func DayNumber(year: Int, month: Int) -> Int {
    var result: Int = 0
    switch month {
    case 1, 3, 5, 7, 8, 10, 12 :
        result = 31
    case 4, 6, 9, 11 :
        result = 30
    case 2:
        if LeapYear(year: year) {
            result = 29
        } else {
            result = 28
        }
    default: break
    }
    return result
}

struct CalendarList: View {
    @Binding var year: Int
    @Binding var month: Int

    var startdaynumber: Int
    var weeknumber: Int
    var days: Int
    var middleweek: Int
    var lastweeknumber: Int
    let column = 7

    init(year: Binding<Int>, month: Binding<Int>, week: Int, start: Int, days: Int) {
        self._year = year
        self._month = month
        self.weeknumber = week
        self.startdaynumber = start
        self.days = days
        self.middleweek = (days - (7 - start)) / 7
        self.lastweeknumber = (days - (7 - start)) % 7
    }

    var body: some View {
        VStack {
            HStack {
                if self.startdaynumber != 0 {
                    ForEach(0..<self.startdaynumber, id: \.self) { _ in
                        ZStack {
                            RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                                .foregroundColor(Color.clear)
                            Text("")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                    }
                }
                ForEach(0..<(self.column-self.startdaynumber), id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                            .foregroundColor(Color.clear)
                        Text("\(index+1)")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                }
            }
            HStack {
                ForEach(0..<self.column, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                            .foregroundColor(Color.clear)
                        Text("\((self.column-self.startdaynumber)+1+index)")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                }
            }
            HStack {
                ForEach(0..<self.column, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                            .foregroundColor(Color.clear)
                        Text("\(((7-self.startdaynumber)+1+index)+7)")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                }
            }
            if self.weeknumber == 4 {
                HStack {
                    if self.lastweeknumber != 0 {
                        ForEach(0..<self.lastweeknumber, id: \.self) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                                    .foregroundColor(Color.clear)
                                Text("\(((7-self.startdaynumber)+1+index)+14)")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                        }
                    } else {
                        ForEach(0..<7, id: \.self) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                                    .foregroundColor(Color.clear)
                                Text("\(((7-self.startdaynumber)+1+index)+14)")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
            } else if self.weeknumber == 5 {
                HStack {
                    ForEach(0..<self.column, id: \.self) { index in
                        ZStack {
                            RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                                .foregroundColor(Color.clear)
                            Text("\(((7-self.startdaynumber)+1+index)+14)")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                    }
                }
                HStack {
                    if self.lastweeknumber != 0 {
                        ForEach(0..<self.lastweeknumber, id: \.self) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                                    .foregroundColor(Color.clear)
                                Text("\(((7-self.startdaynumber)+1+index)+21)")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                        }
                        ForEach(0..<(7-self.lastweeknumber), id: \.self) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                                    .foregroundColor(Color.clear)
                                Text("")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)

                            }
                        }
                    } else {
                        ForEach(0..<7, id: \.self) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                                    .foregroundColor(Color.clear)
                                Text("\(((7-self.startdaynumber)+1+index)+21)")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                        }
                    }

                }
            } else if self.weeknumber == 6 {
                HStack {
                    ForEach(0..<self.column, id: \.self) { index in
                        ZStack {
                            RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                                .foregroundColor(Color.clear)
                            Text("\(((7-self.startdaynumber)+1+index)+14)")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                    }
                }
                HStack {
                    ForEach(0..<self.column, id: \.self) { index in
                        ZStack {
                            RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                                .foregroundColor(Color.clear)
                            Text("\(((7-self.startdaynumber)+1+index)+21)")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                    }
                }
                HStack {
                    if self.lastweeknumber != 0 {
                        ForEach(0..<self.lastweeknumber, id: \.self) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                                    .foregroundColor(Color.clear)
                                Text("\(((7-self.startdaynumber)+1+index)+28)")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                        }
                        if self.lastweeknumber != 0 {
                            ForEach(0..<(7-self.lastweeknumber), id: \.self) {index in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                                        .foregroundColor(Color.clear)
                                    Text("")
                                        .font(.system(size: 20))
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    } else {
                        ForEach(0..<self.lastweeknumber, id: \.self) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 5).frame(width: 40, height: 40)
                                    .foregroundColor(Color.clear)
                                Text("\(((7-self.startdaynumber)+1+index)+28)")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
