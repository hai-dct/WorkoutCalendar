//
//  ArrayExt.swift
//  WorkoutCalendar
//
//  Created by HaiNguyenHP on 06/07/2024.
//

import Foundation

public extension Array {
    func safeIndex(_ index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
