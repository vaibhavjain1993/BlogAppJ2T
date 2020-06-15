//
//  ParentTree+CoreDataProperties.swift
//  CoreDataPOC
//
//  Created by Vaibhav jain on 12/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//
//

import Foundation
import CoreData


extension ParentTree {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ParentTree> {
        return NSFetchRequest<ParentTree>(entityName: "ParentTree")
    }

    @NSManaged public var id: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var content: String?
    @NSManaged public var comments: Int16
    @NSManaged public var likes: Int32
    @NSManaged public var mediaDetail: Set<MediaDetail>?
    @NSManaged public var users: Set<UserInfo>?

}

// MARK: Generated accessors for mediaDetail
extension ParentTree {

    @objc(addMediaDetailObject:)
    @NSManaged public func addToMediaDetail(_ value: MediaDetail)

    @objc(removeMediaDetailObject:)
    @NSManaged public func removeFromMediaDetail(_ value: MediaDetail)

    @objc(addMediaDetail:)
    @NSManaged public func addToMediaDetail(_ values: NSSet)

    @objc(removeMediaDetail:)
    @NSManaged public func removeFromMediaDetail(_ values: NSSet)

}

// MARK: Generated accessors for users
extension ParentTree {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: UserInfo)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: UserInfo)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}
