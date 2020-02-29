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
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    var item1Label = BaseItemLabel()
    var item1Text = BaseItemText()
    
    var item2Label = BaseItemLabel()
    var item2Text = BaseItemText()
    
    var item3Label = BaseItemLabel()
    var item3Text = BaseItemText()

    var item4Text = BaseItemText()
    var item5Text = BaseItemText()
    
    var teacherImage = BaseImage(#imageLiteral(resourceName: "teacher"))

    var data: Displayable? {
        didSet {
            if let imageUrl = data?.item6.value {
                let url = URL(string: imageUrl)
                ImageService.shared.getImage(withURL: url!) { (result) in
                    switch result {
                    case .success(let image):
                        self.teacherImage.image = image
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
    }
    

    // MARK: - Handlers
    
    func configureView() {
        guard let data = data else { return }
        
        let guide = view.safeAreaLayoutGuide
        
        // title: YOGA
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        titleLabel.text = data.titleLableText
        
        // subtitle: Студия 7
        view.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.lastBaselineAnchor, multiplier: 0.5),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        subtitleLabel.text = data.subTitleLableText
        
        // день недели занятия
        view.addSubview(item4Text)
        NSLayoutConstraint.activate([
            item4Text.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.lastBaselineAnchor, multiplier: 0.5),
            item4Text.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        item4Text.text = data.item4.value
        
        // время занятия
        view.addSubview(item5Text)
        NSLayoutConstraint.activate([
            item5Text.topAnchor.constraint(equalToSystemSpacingBelow: item4Text.lastBaselineAnchor, multiplier: 0.5),
            item5Text.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        item5Text.text = data.item5.value
        

        // image: Фото тренера
        view.addSubview(teacherImage)
        NSLayoutConstraint.activate([
            teacherImage.widthAnchor.constraint(equalToConstant: 70),
            teacherImage.heightAnchor.constraint(equalToConstant: 70),
            teacherImage.leadingAnchor.constraint(equalToSystemSpacingAfter: guide.leadingAnchor, multiplier: 1),
            teacherImage.topAnchor.constraint(equalToSystemSpacingBelow: item4Text.lastBaselineAnchor, multiplier: 4)
        ])

        teacherImage.layer.borderWidth = 1
        teacherImage.layer.masksToBounds = false
        teacherImage.layer.borderColor = UIColor.white.cgColor
        teacherImage.layer.cornerRadius = teacherImage.frame.height/2
        teacherImage.clipsToBounds = true

        // teacher name: Титова Елена Ивановна
        view.addSubview(item1Text)
        NSLayoutConstraint.activate([
            item1Text.topAnchor.constraint(equalTo: teacherImage.topAnchor, constant: 6),
            item1Text.leadingAnchor.constraint(equalToSystemSpacingAfter: teacherImage.trailingAnchor, multiplier: 3.5)
        ])
        item1Text.text = data.item1.value
        // teacher position: Мастер-тренер групповых программ
        view.addSubview(item2Text)
        item2Text.font = .preferredFont(forTextStyle: .footnote)
        NSLayoutConstraint.activate([
            item2Text.topAnchor.constraint(equalToSystemSpacingBelow: item1Text.lastBaselineAnchor, multiplier: 0.5),
            item2Text.leadingAnchor.constraint(equalToSystemSpacingAfter: teacherImage.trailingAnchor, multiplier: 3.5)
        ])
        item2Text.text =  data.item2.value
        
        // fit description: Описание занятия
        view.addSubview(item3Text)
        item3Text.numberOfLines = 0
        item3Text.font = .preferredFont(forTextStyle: .body)
        NSLayoutConstraint.activate([
            item3Text.topAnchor.constraint(equalToSystemSpacingBelow: teacherImage.bottomAnchor, multiplier: 1.6),
            item3Text.leadingAnchor.constraint(equalToSystemSpacingAfter: guide.leadingAnchor, multiplier: 2),
            item3Text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -8)
        ])
        item3Text.text =  data.item3.value

    }
}
