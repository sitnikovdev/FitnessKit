//
//  TeacherDetailVC.swift
//  FitnessKit
//
//  Created by Oleg Sitnikov on 29.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import UIKit

class TeacherDetailVC: UIViewController {
    // MARK: - Properties
    
    lazy var viewContainer: UIView = {
        let view =  BaseView(backgroundColor: .white, cornerRadius: 6, borderWidth: 0.5)
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    
    lazy var workoutLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textColor = #colorLiteral(red: 0.5040810704, green: 0.4012541175, blue: 0.3648088276, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var trainerNameLabel = BaseItemText()
    var trainerPositionLabel = BaseItemText()
    var workoutDescriptionLabel = BaseItemText()
    var weekDayLabel = BaseItemText()
    var timesLabel = BaseItemText()
    
    var teacherImage = BaseImage(#imageLiteral(resourceName: "teacher"))
    var calendarIcon = BaseImage(#imageLiteral(resourceName: "calendar"))
    var locationIcon = BaseImage(#imageLiteral(resourceName: "location"))
    var clockIcon = BaseImage(#imageLiteral(resourceName: "clock"))
    
    let divider = BaseView(backgroundColor: #colorLiteral(red: 0.9843137255, green: 0.5254901961, blue: 0.2117647059, alpha: 1))
    
    var data: Displayable? {
        didSet {
            if let imageUrl = data?.trainerImage.value {
                let url = URL(string: imageUrl)!
                teacherImage.af.setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "teacher"))
        }
    }
}

// MARK: - Setup

override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    navigationItem.largeTitleDisplayMode = .never
    configureView()
}

// MARK: - Handlers

func configureView() {
    guard let data = data else { return }
    
    let guide = view.safeAreaLayoutGuide
    
    // view container
    view.addSubview(viewContainer)
    NSLayoutConstraint.activate([
        viewContainer.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 8),
        viewContainer.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8),
        viewContainer.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -8),
        viewContainer.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 8)
    ])
    
    //  workout title
    viewContainer.addSubview(workoutLabel)
    workoutLabel.text = data.workoutName
    NSLayoutConstraint.activate([
        workoutLabel.topAnchor.constraint(equalToSystemSpacingBelow: viewContainer.topAnchor, multiplier: 1),
        workoutLabel.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor)
    ])
    
    // location icon
    viewContainer.addSubview(locationIcon)
    NSLayoutConstraint.activate([
        locationIcon.heightAnchor.constraint(equalToConstant: 16),
        locationIcon.widthAnchor.constraint(equalToConstant: 12),
        locationIcon.topAnchor.constraint(equalTo: workoutLabel.lastBaselineAnchor, constant: 24),
        locationIcon.leadingAnchor.constraint(equalTo: workoutLabel.leadingAnchor, constant: 0)
    ])
    
    // place: Студия 7
    viewContainer.addSubview(placeLabel)
    placeLabel.text = data.workoutPlace
    NSLayoutConstraint.activate([
        placeLabel.topAnchor.constraint(equalTo: locationIcon.topAnchor, constant: -2),
        placeLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 8)
    ])
    // calendar icon
    viewContainer.addSubview(calendarIcon)
    NSLayoutConstraint.activate([
        calendarIcon.widthAnchor.constraint(equalToConstant: 24),
        calendarIcon.heightAnchor.constraint(equalToConstant: 24),
        calendarIcon.topAnchor.constraint(equalTo: placeLabel.lastBaselineAnchor, constant: 32),
        calendarIcon.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 16)
    ])
    
    // день недели занятия
    viewContainer.addSubview(weekDayLabel)
    weekDayLabel.textColor = #colorLiteral(red: 0.3000817895, green: 0.5665410757, blue: 0.4783787131, alpha: 1)
    weekDayLabel.text = data.week.value
    NSLayoutConstraint.activate([
        weekDayLabel.topAnchor.constraint(equalTo: calendarIcon.topAnchor, constant: 0),
        weekDayLabel.leadingAnchor.constraint(equalTo: calendarIcon.trailingAnchor, constant: 8)
    ])
    
    // clock icon
    viewContainer.addSubview(clockIcon)
    NSLayoutConstraint.activate([
        clockIcon.widthAnchor.constraint(equalToConstant: 16),
        clockIcon.heightAnchor.constraint(equalToConstant: 16),
        clockIcon.topAnchor.constraint(equalTo: calendarIcon.bottomAnchor, constant: 8),
        clockIcon.leadingAnchor.constraint(equalTo: calendarIcon.leadingAnchor, constant: 4)
    ])
    
    // время занятия
    viewContainer.addSubview(timesLabel)
    timesLabel.text = data.time.value
    timesLabel.font = .preferredFont(forTextStyle: .subheadline)
    NSLayoutConstraint.activate([
        timesLabel.topAnchor.constraint(equalTo: calendarIcon.topAnchor, constant: 30),
        timesLabel.leadingAnchor.constraint(equalTo: weekDayLabel.leadingAnchor, constant: 0)
    ])
    
    
    // image: Фото тренера
    viewContainer.addSubview(teacherImage)
    NSLayoutConstraint.activate([
        teacherImage.widthAnchor.constraint(equalToConstant: 70),
        teacherImage.heightAnchor.constraint(equalToConstant: 70),
        teacherImage.leadingAnchor.constraint(equalToSystemSpacingAfter: viewContainer.leadingAnchor, multiplier: 1),
        teacherImage.topAnchor.constraint(equalToSystemSpacingBelow: weekDayLabel.lastBaselineAnchor, multiplier: 4)
    ])
    
    teacherImage.layer.borderWidth = 1
    teacherImage.layer.masksToBounds = false
    teacherImage.layer.borderColor = UIColor.white.cgColor
    teacherImage.layer.cornerRadius = teacherImage.frame.height/2
    teacherImage.clipsToBounds = true
    
    // teacher name: Титова Елена Ивановна
    viewContainer.addSubview(trainerNameLabel)
    trainerNameLabel.text = data.trainerName.value
    trainerNameLabel.font = .preferredFont(forTextStyle: .callout)
    NSLayoutConstraint.activate([
        trainerNameLabel.topAnchor.constraint(equalTo: teacherImage.topAnchor, constant: 20),
        trainerNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: teacherImage.trailingAnchor, multiplier: 3.5)
    ])
    // teacher position: Мастер-тренер групповых программ
    viewContainer.addSubview(trainerPositionLabel)
    trainerPositionLabel.text =  data.trainerPosition.value
    trainerPositionLabel.font = .preferredFont(forTextStyle: .footnote)
    NSLayoutConstraint.activate([
        trainerPositionLabel.topAnchor.constraint(equalTo: trainerNameLabel.lastBaselineAnchor, constant: 8),
        trainerPositionLabel.leadingAnchor.constraint(equalTo: teacherImage.trailingAnchor, constant: 4)
    ])
    
    // divider
    viewContainer.addSubview(divider)
    NSLayoutConstraint.activate([
        divider.heightAnchor.constraint(equalToConstant: 3),
        divider.widthAnchor.constraint(equalToConstant: 330),
        divider.topAnchor.constraint(equalTo: trainerPositionLabel.bottomAnchor, constant: 32),
        divider.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor)
    ])
    
    // fit description: Описание занятия
    viewContainer.addSubview(workoutDescriptionLabel)
    let attributedString = NSMutableAttributedString(string: data.workoutDescription.value)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 2
    paragraphStyle.alignment = .left
    paragraphStyle.firstLineHeadIndent = 20
    paragraphStyle.lineBreakMode = .byTruncatingTail
    attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
    workoutDescriptionLabel.attributedText = attributedString
    workoutDescriptionLabel.numberOfLines = 0
    workoutDescriptionLabel.font = .preferredFont(forTextStyle: .body)
    NSLayoutConstraint.activate([
        workoutDescriptionLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant:  16),
        workoutDescriptionLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: viewContainer.leadingAnchor, multiplier: 2),
        workoutDescriptionLabel.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant:  -8)
    ])
    
}
}
