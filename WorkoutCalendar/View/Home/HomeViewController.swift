//
//  HomeViewController.swift
//  WorkoutCalendar
//
//  Created by HaiNguyenHP on 05/07/2024.
//

import UIKit
import SwifterSwift
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(nibWithCellClass: HomeTableViewCell.self)
            let rf = UIRefreshControl()
            rf.rx.controlEvent(.valueChanged).bind(to: viewModel.refreshTable).disposed(by: bag)
            tableView.refreshControl = rf
        }
    }

    let viewModel: HomeViewModel = .init()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadTableViewData.subscribe(onNext:  { [weak self] in
            self?.tableView.refreshControl?.endRefreshing()
            self?.tableView.reloadData()
        }).disposed(by: bag)
        viewModel.viewDidLoad.accept(())
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
}

//// MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.datesOfWeek.value.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = viewModel.datesOfWeek.value[section]
        guard let daydata = viewModel.dayDatas.value.first(where: { item in
            item.day == date.string(withFormat: "MM-dd-yyyy")
        }) else { return 1 }
        return daydata.assignments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: HomeTableViewCell.self)
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cell
    }
}
