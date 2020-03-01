//
//  Displayable.swift
//  FitnessKit
//
//  Created by Oleg Sitnikov on 29.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//
protocol Displayable {
    var workoutName: String { get }
    var workoutPlace: String { get }
    var trainerName: (label: String, value: String) { get }
    var trainerPosition: (label: String, value: String) { get }
    var workoutDescription: (label: String, value: String) { get }
    var week: (label: String, value: String) { get }
    var time: (label: String, value: String) { get }
    var workoutStartTime: (label: String, value: String) { get }
    var workoutEndTime: (label: String, value: String) { get }
    var trainerImage: (label: String, value: String) { get }
}
