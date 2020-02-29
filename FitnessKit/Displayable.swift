//
//  Displayable.swift
//  FitnessKit
//
//  Created by Oleg Sitnikov on 29.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//
protocol Displayable {
    var titleLableText: String { get }
    var subTitleLableText: String { get }
    var item1: (label: String, value: String) { get }
    var item2: (label: String, value: String) { get }
    var item3: (label: String, value: String) { get }
    var item4: (label: String, value: String) { get }
    var item5: (label: String, value: String) { get }
    var item6: (label: String, value: String) { get }
}
