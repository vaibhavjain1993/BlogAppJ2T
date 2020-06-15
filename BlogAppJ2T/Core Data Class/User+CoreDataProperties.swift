//
//  User+CoreDataProperties.swift
//  CoreDataPOC
//
//  Created by Vaibhav jain on 12/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var blogId: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var name: String?
    @NSManaged public var avatar: String?
    @NSManaged public var lastname: String?
    @NSManaged public var city: String?
    @NSManaged public var designation: String?
    @NSManaged public var about: String?
    @NSManaged public var parentTree: ParentTree?

}
