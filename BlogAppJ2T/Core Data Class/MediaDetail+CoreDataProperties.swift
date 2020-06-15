//
//  MediaDetail+CoreDataProperties.swift
//  CoreDataPOC
//
//  Created by Vaibhav jain on 12/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//
//

import Foundation
import CoreData


extension MediaDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MediaDetail> {
        return NSFetchRequest<MediaDetail>(entityName: "MediaDetail")
    }

    @NSManaged public var id: String?
    @NSManaged public var blogId: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var parentTreeMedia: ParentTree?

}
