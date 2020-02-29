//
//  WeekDays.swift
//  FitnessKit
//
//  Created by Oleg Sitnikov on 29.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import Foundation

enum WeekDays: Int, CustomStringConvertible {
    case Monday = 1, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
    
    var description: String {
        switch self {
        case .Monday:
            return "Monday"
        case .Tuesday:
            return "Tuesday"
        case .Wednesday:
            return "Wednesday"
        case .Thursday:
            return "Thursday"
        case .Friday:
            return "Friday"
        case .Saturday:
            return "Saturday"
        case .Sunday:
            return "Sunday"
        }
    }
    
}
