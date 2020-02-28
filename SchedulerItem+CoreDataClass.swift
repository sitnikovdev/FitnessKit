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
    
    enum CodingKeys: String, CodingKey {
        case id = "appointment_id"
        case name
        case teacher
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else {
            fatalError("CodingUserKey not found")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "SchedulerItem", in: context) else { fatalError("Entity not found") }
        
        self.init(entity: entity, insertInto: context)
        
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        teacher = try container.decode(String.self, forKey: .teacher)
    }

}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
