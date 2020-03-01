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
    
    let viewContainer = BaseView(backgroundColor: .white, cornerRadius: 6, borderWidth: 1)
    let workout = BaseItemText()
    let startTime = BaseItemText()
    let endTime = BaseItemText()
    let place = BaseItemText()
    var dividerView: UIView =  {
        let view = BaseView(backgroundColor: .systemGray)
        return view
    }()
    
    let teacher = BaseItemText()
    let teacherImage = BaseImage(#imageLiteral(resourceName: "teacher"), frame: CGRect(x: 100, y: 100, width: 45, height: 45))
    let locationImage = BaseImage(#imageLiteral(resourceName: "icn_location") , frame: CGRect(x: 100, y: 150, width: 70, height: 70))
    let timeDivider = BaseImage(#imageLiteral(resourceName: "icn_time"), frame: CGRect(x: 100, y: 100, width: 100, height: 20))
    let disclosure = BaseImage(#imageLiteral(resourceName: "icn_disclosure"), frame: CGRect(x: 100, y: 100, width: 50, height: 50))
    
    static let reuseIdentifer = "SchedulerCell"
    var schedulerItem: Displayable! {
        didSet {
            workout.text = schedulerItem.workoutName
            place.text = schedulerItem.workoutPlace
            teacher.text = schedulerItem.trainerName.value
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
            startTime.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 32),
            startTime.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 20)
        ])
        
        //  time divider
        viewContainer.addSubview(timeDivider)
        NSLayoutConstraint.activate([
            timeDivider.topAnchor.constraint(equalTo: startTime.bottomAnchor, constant: 8),
            timeDivider.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 20)
        ])
        
        // end time
        viewContainer.addSubview(endTime)
        endTime.font = .preferredFont(forTextStyle: .subheadline)
        NSLayoutConstraint.activate([
            endTime.topAnchor.constraint(equalTo: startTime.lastBaselineAnchor, constant: 24),
            endTime.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 20)
        ])
        
        
        // divider
        viewContainer.addSubview(dividerView)
        NSLayoutConstraint.activate([
            dividerView.widthAnchor.constraint(equalToConstant: 1),
            dividerView.heightAnchor.constraint(equalToConstant: 70),
            dividerView.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            dividerView.leadingAnchor.constraint(equalTo: startTime.trailingAnchor, constant: 20)
        ])
        
        // workout
        viewContainer.addSubview(workout)
        workout.font = .boldSystemFont(ofSize: 17)
        NSLayoutConstraint.activate([
            workout.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 8),
            workout.leadingAnchor.constraint(equalTo: dividerView.trailingAnchor, constant: 72)
        ])
        
        
        // location
        viewContainer.addSubview(locationImage)
        NSLayoutConstraint.activate([
            locationImage.topAnchor.constraint(equalTo: workout.lastBaselineAnchor, constant: 12),
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
        viewContainer.addSubview(teacher)
        NSLayoutConstraint.activate([
            teacher.topAnchor.constraint(equalTo: place.lastBaselineAnchor, constant: 30),
            teacher.leadingAnchor.constraint(equalTo: teacherImage.trailingAnchor, constant: 10)
        ])
        
        // disclosure
        viewContainer.addSubview(disclosure)
        NSLayoutConstraint.activate([
            disclosure.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            disclosure.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -16)
        ])
        
    }
    
}
