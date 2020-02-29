//
//  Workout.swift
//  FitnessKit
//
//  Created by Oleg Sitnikov on 29.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import Foundation

enum Workout: String, CustomStringConvertible {
    case Yoga = "Yoga ", Stretch = "Stretch"
    
    var description: String {
        switch self {
        case .Yoga:
            return "Йога"
        case .Stretch:
            return "Растяжка"
        }
    }
}
