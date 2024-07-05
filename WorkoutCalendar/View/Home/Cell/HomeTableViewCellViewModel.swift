//
//  HomeTableViewCellViewModel.swift
//  WorkoutCalendar
//
//  Created by HaiNguyenHP on 05/07/2024.
//

import Foundation
import RxSwift
import RxCocoa


class HomeTableViewCellViewModel {
 
    let state: HomeViewModel.State
    let date: Date
    let assignment: Assignment?
    let needShowDay: Bool
    let needShowSeperator: Bool
    
    init(date: Date, assignment: Assignment?, needShowDay: Bool, needShowSeperator: Bool = true, state: HomeViewModel.State) {
        self.date = date
        self.assignment = assignment
        self.needShowDay = needShowDay
        self.needShowSeperator = needShowSeperator
        self.state = state
    }
}
