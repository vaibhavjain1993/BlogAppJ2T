//
//  CoreDataManager.swift
//  BlogAppJ2T
//
//  Created by Gaurav Kabra on 13/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager: NSObject {

    class func addRecord(article:[String:Any]) {
        let person = NSEntityDescription.insertNewObject(forEntityName: "ParentTree", into: CoreDataStack.shared.persistentContainer.viewContext) as! ParentTree
        person.id = article["id"] as? String
        person.createdAt = article["createdAt"] as? String
        person.content = article["content"] as? String
        person.comments = article["comments"] as? Int16 ?? 0
        person.likes = article["likes"] as? Int32 ?? 0

        if let medias = article["media"] as? [[String : Any]]{
            for media in medias{
                let mediaInfo = NSEntityDescription.insertNewObject(forEntityName: "MediaDetail", into: CoreDataStack.shared.persistentContainer.viewContext) as! MediaDetail
                mediaInfo.id = media["id"] as? String
                mediaInfo.blogId = media["blogId"] as? String
                mediaInfo.createdAt = media["createdAt"] as? String
                mediaInfo.image = media["image"] as? String
                mediaInfo.title = media["title"] as? String
                mediaInfo.url = media["url"] as? String
                person.addToMediaDetail(mediaInfo)
            }
        }

        if let userInfo = article["user"] as? [[String : Any]]{
            for user in userInfo{
                let userData = NSEntityDescription.insertNewObject(forEntityName: "User", into: CoreDataStack.shared.persistentContainer.viewContext) as! UserInfo
                userData.id = user["id"] as? String
                userData.blogId = user["blogId"] as? String
                userData.createdAt = user["createdAt"] as? String
                userData.name = user["name"] as? String
                userData.avatar = user["avatar"] as? String
                userData.lastname = user["lastname"] as? String
                userData.designation = user["designation"] as? String
                userData.about = user["about"] as? String
                person.addToUsers(userData)
            }
        }
        CoreDataStack.shared.saveContext()
    }

    class func getRecords(offset : Int) -> [ParentTree]? {
        let request:NSFetchRequest<ParentTree> = ParentTree.fetchRequest()
        request.fetchOffset = offset
        request.fetchLimit = 10
        do {
            let results = try CoreDataStack.shared.persistentContainer.viewContext.fetch(request)
            return results
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    class func deleteAllParentRecords() {
        //getting context from your Core Data Manager Class
        let managedContext = CoreDataStack.shared.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ParentTree")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch {
            print ("There is an error in deleting records")
        }
    }

    class func deleteAllMediaRecords() {
        //getting context from your Core Data Manager Class
        let managedContext = CoreDataStack.shared.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "MediaDetail")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch {
            print ("There is an error in deleting records")
        }
    }

    class func deleteAllUserRecords() {
        //getting context from your Core Data Manager Class
        let managedContext = CoreDataStack.shared.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch {
            print ("There is an error in deleting records")
        }
    }
}
