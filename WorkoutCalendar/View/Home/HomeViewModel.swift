//
//  HomeViewModel.swift
//  WorkoutCalendar
//
//  Created by HaiNguyenHP on 05/07/2024.
//

import Foundation
import RxSwift
import RxCocoa


protocol HomeViewModelInput {
    var viewDidLoad: PublishRelay<Void> { get }
    var refreshTable: PublishRelay<Void> { get }
}
protocol HomeViewModelOutput {
    var dayDatas: BehaviorRelay<[DayData]> { get }
    var reloadTableViewData: PublishRelay<Void> { get }
    var datesOfWeek: BehaviorRelay<[Date]> { get }
}


class HomeViewModel: HomeViewModelInput, HomeViewModelOutput {
    // MARK: - Inputs
    let viewDidLoad: PublishRelay<Void> = .init()
    let refreshTable: PublishRelay<Void> = .init()
    
    // MARK: - Outputs
    let reloadTableViewData: PublishRelay<Void> = .init()
    let dayDatas: BehaviorRelay<[DayData]> = .init(value: [])
    let datesOfWeek: BehaviorRelay<[Date]>
    
    // MARK: - Properties
    private let currentDate: Date
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    init(currentDate: Date = Date(year: 2024, month: 5, day: 24)!) {
        self.currentDate = currentDate
        self.datesOfWeek = .init(value: currentDate.datesOfWeek(using: Calendar(identifier: .iso8601)))
        bindOutputs()
    }
    
    // MARK: - Private Methods
    private func bindOutputs() {
        dayDatas
            .map { _ in }
            .bind(to: reloadTableViewData)
            .disposed(by: disposeBag)
        
        Observable.merge(viewDidLoad.asObservable(), refreshTable.asObservable())
            .subscribe(onNext: { [weak self] in
                self?.fetchData()
            })
            .disposed(by: disposeBag)
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> HomeTableViewCellViewModel{
        let date = datesOfWeek.value[indexPath.section]
        let daydata = dayDatas.value.first { $0.day == date.string(withFormat: "MM-dd-yyyy") }
        let assignment = daydata?.assignments.safeIndex(indexPath.row)
        let needShowSeperator = indexPath.row == (daydata?.assignments.count ?? 1) - 1
        
        let state: State = {
            switch true {
            case currentDate < date:
                return .future
            case currentDate.isSameDay(as: date):
                return .assigned
            case assignment?.exercisesCount ?? 0 > assignment?.exercisesCompleted ?? 0:
                return .missed
            default:
                return .completed
            }
        }()
        
        return HomeTableViewCellViewModel(date: date, assignment: assignment, needShowDay: indexPath.row == 0, needShowSeperator: needShowSeperator, state: state)
    }
    
    func fetchData() {
        guard let url = URL(string: "https://demo6732818.mockable.io/workouts") else {
            return
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { data in
                try decoder.decode(APIResponse.self, from: data)
            }
            .map { $0.dayData }
            .catchAndReturn(DataFileManager.shared.loadDayDatas())
            .do(onNext: { daydatas in
                DataFileManager.shared.saveDayDatas(daydatas: daydatas)
            })
            .observe(on: MainScheduler.instance)
            .bind(to: dayDatas)
            .disposed(by: disposeBag)
    }
}

extension HomeViewModel {
  
    struct APIResponse: Codable {
        let dayData: [DayData]
    }
    
    enum State {
        case missed
        case completed
        case assigned
        case future
    }
}

