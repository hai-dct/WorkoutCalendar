//
//  Assignment.swift
//  WorkoutCalendar
//
//  Created by HaiNguyenHP on 05/07/2024.
//

import Foundation

struct Assignment: Codable {
    let _id: String
    let status: Int
    let client: String
    let title: String
    let day: String
    let date: String
    let exercisesCompleted: Int
    let exercisesCount: Int
    let startDate: String?
    let endDate: String?
    let duration: Int?
    let rating: Int?
}
