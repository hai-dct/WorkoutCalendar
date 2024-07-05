//
//  DateExt.swift
//  WorkoutCalendar
//
//  Created by HaiNguyenHP on 05/07/2024.
//

import Foundation

extension Date {
    func toWeekday() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    func startOfWeek(using calendar: Calendar = Calendar.current) -> Date? {
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return calendar.date(from: components)
    }
    
    func endOfWeek(using calendar: Calendar = Calendar.current) -> Date? {
        guard let startOfWeek = self.startOfWeek(using: calendar) else { return nil }
        return calendar.date(byAdding: .day, value: 6, to: startOfWeek)
    }
    
    func datesOfWeek(using calendar: Calendar = Calendar.current) -> [Date] {
        guard let startOfWeek = self.startOfWeek(using: calendar) else { return [] }
        var dates: [Date] = []
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                dates.append(date)
            }
        }
        return dates
    }
    
    func formattedDate(using formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }
    
    func isSameDay(as otherDate: Date, using calendar: Calendar = Calendar.current) -> Bool {
        let components1 = calendar.dateComponents([.year, .month, .day], from: self)
        let components2 = calendar.dateComponents([.year, .month, .day], from: otherDate)
        return components1 == components2
    }
}
