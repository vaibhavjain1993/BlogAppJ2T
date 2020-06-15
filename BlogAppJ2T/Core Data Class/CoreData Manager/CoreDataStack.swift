//
//  CoreDataStack.swift
//  BlogAppJ2T
//
//  Created by Gaurav Kabra on 13/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {

    static let moduleName = "BlogAppJ2T"
    static let shared = CoreDataStack()

    private override init() {
        super.init()
        _ = self.persistentContainer
    }

    func saveContext () {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {

                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: CoreDataStack.moduleName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            print("Coordinator URL - \(storeDescription)")
        })
        return container
    }()
}
