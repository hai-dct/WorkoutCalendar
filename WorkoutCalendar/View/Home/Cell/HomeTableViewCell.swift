//
//  HomeTableViewCell.swift
//  WorkoutCalendar
//
//  Created by HaiNguyenHP on 05/07/2024.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var dayStackView: UIStackView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var checkIcon: UIImageView!
    
    @IBOutlet weak var topLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    
    var viewModel: HomeTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        containerView.backgroundColor = selected ? UIColor(red: 116, green: 112, blue: 239) : UIColor(red: 247, green: 248, blue: 252)
        checkIcon.isHidden = !selected
        titleLabel.textColor = selected ? .white : .black
        statusLabel.textColor = selected ?.white : .red
        countLabel.textColor = selected ? .white : .black
    }
    
    func updateView() {
        guard let vm = viewModel else { return }
        containerView.isHidden = vm.assignment == nil
        statusLabel.isHidden = vm.state != .missed

        titleLabel.text = vm.assignment?.title
        countLabel.text = vm.state == .missed ? "• \(vm.assignment?.exercisesCount ?? 0) exercises" : "\(vm.assignment?.exercisesCount ?? 0) exercises"
        dayStackView.isHidden = !vm.needShowDay
        dayLabel.text = vm.date.day.string
        dayLabel.textColor = vm.state == .assigned ? UIColor(red: 116, green: 112, blue: 239) : .black
        weekdayLabel.text = vm.date.toWeekday()
        weekdayLabel.textColor = vm.state == .assigned ? UIColor(red: 116, green: 112, blue: 239) : UIColor(red: 123, green: 126, blue: 145)
        separatorInset = vm.needShowSeperator ? .zero : UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
        containerView.alpha = vm.state == .future ? 0.5 : 1
        containerView.backgroundColor = vm.state == .completed ? UIColor(red: 116, green: 112, blue: 239) : UIColor(red: 247, green: 248, blue: 252)
        
        topLayoutConstraint.priority = UILayoutPriority(vm.needShowDay ? 750 : 250)
        bottomLayoutConstraint.priority = UILayoutPriority(vm.needShowDay && vm.needShowSeperator ? 750 : 250)
    }
    
    
}
