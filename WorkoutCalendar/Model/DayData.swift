//
//  DayData.swift
//  WorkoutCalendar
//
//  Created by HaiNguyenHP on 05/07/2024.
//

import Foundation

struct DayData: Codable {
    let _id: String
    let assignments: [Assignment]
    let trainer: String
    let client: String
    let day: String
    let date: String
}
