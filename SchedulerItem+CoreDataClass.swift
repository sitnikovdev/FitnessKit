//
//  SchedulerItem+CoreDataClass.swift
//  FitnessKit
//
//  Created by Oleg Sitnikov on 27.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SchedulerItem)
public class SchedulerItem: NSManagedObject, Decodable {
    
    enum RootCodingKeys: String, CodingKey {
        case id = "appointment_id"
        case name
        case fitDescription = "description"
        case teacher
        case weekDay
        case place
        case teacherInfo = "teacher_v2"
        case startTime
        case endTime
    }
    
    enum TeacherCodingKeys: String, CodingKey {
        case teacherName = "name"
        case teacherShortName = "short_name"
        case teacherPosition = "position"
        case teacherImageUrl = "imageUrl"
    }
    
    
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else {
            fatalError("CodingUserKey not found")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "SchedulerItem", in: context) else { fatalError("Entity not found") }
        
        self.init(entity: entity, insertInto: context)
        
        
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        id = try rootContainer.decode(String.self, forKey: .id)
        name = try rootContainer.decode(String.self, forKey: .name)
        fitDescription = try rootContainer.decode(String.self, forKey: .fitDescription)
        teacher = try rootContainer.decode(String.self, forKey: .teacher)
        place = try rootContainer.decode(String.self, forKey: .place)
        weekDay = try rootContainer.decode(Int.self, forKey: .weekDay)
        startTime = try rootContainer.decode(String.self, forKey: .startTime)
        endTime = try rootContainer.decode(String.self, forKey: .endTime)
        
        let teacherContainer = try rootContainer.nestedContainer(keyedBy: TeacherCodingKeys.self, forKey: .teacherInfo)
        teacherName = try teacherContainer.decode(String.self, forKey: .teacherName)
        teacherShortName = try teacherContainer.decode(String.self, forKey: .teacherShortName)
        teacherPosition = try teacherContainer.decode(String.self, forKey: .teacherPosition)
        teacherImageUrl = try teacherContainer.decode(String.self, forKey: .teacherImageUrl)
        
    }

}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}


extension SchedulerItem: Displayable {

    var subTitleLableText: String {
        place
    }
    
    var titleLableText: String {
        Workout(rawValue: name)?.description ?? ""
    }

    var item1: (label: String, value: String) {
        ("ИНСТРУКТОР",  teacherName)
    }
    
    var item2: (label: String, value: String) {
        ("ПОЗИЦИЯ", teacherPosition)
    }
    
    var item3: (label: String, value: String) {
        ("ОПИСАНИЕ", fitDescription)
    }
    
    var item4: (label: String, value: String) {
        ("День недели", WeekDays(rawValue: weekDay + 1)?.description ?? "")
    }
    
    var item5: (label: String, value: String) {
        ("Время заняния", "c \(startTime) до \(endTime)" )
    }
    
    var item6: (label: String, value: String) {
        ("URL фото тренера", teacherImageUrl )
    }
}
