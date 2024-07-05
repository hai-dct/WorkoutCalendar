//
//  StringExt.swift
//  WorkoutCalendar
//
//  Created by HaiNguyenHP on 05/07/2024.
//

import Foundation

extension String {
    /// Converts an ISO 8601 date string to a `Date` object.
    /// - Returns: A `Date` object if the string is a valid ISO 8601 date, otherwise `nil`.
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self)
    }
}
