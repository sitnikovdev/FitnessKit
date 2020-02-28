//
//  SchedulerItem+CoreDataProperties.swift
//  FitnessKit
//
//  Created by Oleg Sitnikov on 27.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//
//

import Foundation
import CoreData


extension SchedulerItem {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<SchedulerItem> {
        return NSFetchRequest<SchedulerItem>(entityName: "SchedulerItem")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var teacher: String

}
