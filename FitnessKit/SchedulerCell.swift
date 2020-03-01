//
//  SchedulerCell.swift
//  FitnessKit
//
//  Created by Oleg Sitnikov on 01.03.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//
import UIKit

class SchedulerCell: UITableViewCell {
    // MARK: - Properties
    
//    let viewContainer = BaseView(backgroundColor: .white, cornerRadius: 6, borderWidth: 1)
    
    lazy var viewContainer: UIView = {
        let view =  BaseView(backgroundColor: .white, cornerRadius: 6, borderWidth: 0.5)
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    let workout = BaseItemText()
    let startTime = BaseItemText()
    let endTime = BaseItemText()
    let place = BaseItemText()
    var dividerView: UIView =  {
        let view = BaseView(backgroundColor: #colorLiteral(red: 0.9843137255, green: 0.5254901961, blue: 0.2117647059, alpha: 1))
        return view
    }()
    
    let trainerLabel = BaseItemText()
    let teacherImage = BaseImage(#imageLiteral(resourceName: "teacher"), frame: CGRect(x: 100, y: 100, width: 45, height: 45))
    let locationImage = BaseImage(#imageLiteral(resourceName: "location") , frame: CGRect(x: 100, y: 150, width: 70, height: 70))
    let timeDivider = BaseImage(#imageLiteral(resourceName: "icn_time"), frame: CGRect(x: 100, y: 100, width: 100, height: 20))
    let disclosure = BaseImage(#imageLiteral(resourceName: "icn_disclosure"), frame: CGRect(x: 100, y: 100, width: 50, height: 50))
    let clockIcon = BaseImage(#imageLiteral(resourceName: "clock"), frame: CGRect(x: 100, y: 100, width: 50, height: 50))
    
    
    static let reuseIdentifer = "SchedulerCell"
    var schedulerItem: Displayable! {
        didSet {
            workout.text = schedulerItem.workoutName
            workout.textColor = #colorLiteral(red: 0.5040810704, green: 0.4012541175, blue: 0.3648088276, alpha: 1)
            place.text = schedulerItem.workoutPlace
            trainerLabel.text = schedulerItem.trainerName.value
            startTime.text = schedulerItem.workoutStartTime.value
            endTime.text = schedulerItem.workoutEndTime.value
            let imageUrl = URL(string: schedulerItem.trainerImage.value)
            ImageService.shared.getImage(withURL: imageUrl!) { (result) in
                switch result{
                case .success(let image):
                    self.teacherImage.image = image
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Setup
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        // container
        contentView.addSubview(viewContainer)
        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2),
            viewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            viewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            viewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        
        // start time
        viewContainer.addSubview(startTime)
        startTime.font = .preferredFont(forTextStyle: .subheadline)
        NSLayoutConstraint.activate([
            startTime.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 24),
            startTime.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 20)
        ])
        
        //  time divider
        viewContainer.addSubview(clockIcon)
        NSLayoutConstraint.activate([
            clockIcon.heightAnchor.constraint(equalToConstant: 16),
            clockIcon.widthAnchor.constraint(equalToConstant: 16),
            clockIcon.topAnchor.constraint(equalTo: startTime.bottomAnchor, constant: 4),
            clockIcon.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 32)
        ])
        
        // end time
        viewContainer.addSubview(endTime)
        endTime.font = .preferredFont(forTextStyle: .subheadline)
        NSLayoutConstraint.activate([
            endTime.topAnchor.constraint(equalTo: startTime.lastBaselineAnchor, constant: 32),
            endTime.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 20)
        ])
        
        
        // divider
        viewContainer.addSubview(dividerView)
        NSLayoutConstraint.activate([
            dividerView.widthAnchor.constraint(equalToConstant: 3),
            dividerView.heightAnchor.constraint(equalToConstant: 70),
            dividerView.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            dividerView.leadingAnchor.constraint(equalTo: startTime.trailingAnchor, constant: 20)
        ])
        
        // workout
        viewContainer.addSubview(workout)
        workout.font = .boldSystemFont(ofSize: 20)
        NSLayoutConstraint.activate([
            workout.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 8),
            workout.leadingAnchor.constraint(equalTo: dividerView.trailingAnchor, constant: 72)
        ])
        
        
        // location
        viewContainer.addSubview(locationImage)
        NSLayoutConstraint.activate([
            locationImage.heightAnchor.constraint(equalToConstant: 16),
            locationImage.widthAnchor.constraint(equalToConstant: 12),
            locationImage.topAnchor.constraint(equalTo: workout.lastBaselineAnchor, constant: 10),
            locationImage.leadingAnchor.constraint(equalTo: workout.leadingAnchor, constant: 0)
        ])
        
        // places
        viewContainer.addSubview(place)
        place.font = .preferredFont(forTextStyle: .callout)
        place.textColor = .systemGray
        NSLayoutConstraint.activate([
            place.topAnchor.constraint(equalTo: workout.lastBaselineAnchor, constant: 8),
            place.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 8)
        ])
        
        // teacherImage
        viewContainer.addSubview(teacherImage)
        NSLayoutConstraint.activate([
            teacherImage.widthAnchor.constraint(equalToConstant: 45),
            teacherImage.heightAnchor.constraint(equalToConstant: 45),
            teacherImage.topAnchor.constraint(equalTo: place.lastBaselineAnchor, constant: 8),
            teacherImage.leadingAnchor.constraint(equalTo: dividerView.trailingAnchor, constant: 20)
        ])
        
        teacherImage.layer.borderWidth = 1
        teacherImage.layer.masksToBounds = false
        teacherImage.layer.borderColor = UIColor.white.cgColor
        teacherImage.layer.cornerRadius = teacherImage.frame.height/3
        teacherImage.clipsToBounds = true
        
        // trainer
        viewContainer.addSubview(trainerLabel)
        trainerLabel.font = .preferredFont(forTextStyle: .body)
        NSLayoutConstraint.activate([
            trainerLabel.topAnchor.constraint(equalTo: teacherImage.topAnchor, constant: 12),
            trainerLabel.leadingAnchor.constraint(equalTo: teacherImage.trailingAnchor, constant: 10)
        ])
        
        // disclosure
        viewContainer.addSubview(disclosure)
        NSLayoutConstraint.activate([
            disclosure.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            disclosure.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -16)
        ])
        
    }
    
}
