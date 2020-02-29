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
            return "Понедельник"
        case .Tuesday:
            return "Вторник"
        case .Wednesday:
            return "Среда"
        case .Thursday:
            return "Четверг"
        case .Friday:
            return "Пятница"
        case .Saturday:
            return "Суббота"
        case .Sunday:
            return "Воскресенье"
        }
    }
    
}
