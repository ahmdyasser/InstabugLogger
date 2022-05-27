//
//  PersistenceManager.swift
//  InstabugInternshipTask
//
//  Created by Ahmad Yasser on 24/05/2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK: - Core Data stack
    
    static let shared = CoreDataManager()
    private let entityName = "LoggerEntity"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "InstabugLoggerModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    lazy var backgroundContext: NSManagedObjectContext = {
       let context = persistentContainer.newBackgroundContext()
       context.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
       return context
     }()

    
     lazy var mainContext: NSManagedObjectContext = {
       let context = persistentContainer.viewContext
       context.automaticallyMergesChangesFromParent = true
       return context
     }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                fatalError("Unresolved error \(error)")
            }
        }
        
        
    }
    
}

extension CoreDataManager {
    
    
    /// Delete a log at a specific index.
    /// - Parameters:
    ///     - index:  The index at which you delete data.
    ///     - deletedData:  The data before deleting.
    func deleteLogAt(index: Int, deletedData: [LoggerEntity]) {
            mainContext.delete(deletedData[index])
            self.saveContext()
        
    }
    
    
    /// Clear all the saved data.
    /// - Parameters:
    ///     - entity:  The entity name which you want to clear from
    func clearLog(for entity: String) {
        let request = NSFetchRequest<LoggerEntity>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try mainContext.fetch(request)
            for managedObject in results {
                mainContext.delete(managedObject)
            }
        } catch let error as NSError {
            print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
        }
        
        saveContext()
    }
    
    
    /// Save a log to Core Data
    /// - Parameters:
    ///     - logger:  A logger instance
    func saveLog(logger: LoggerModel) {
        
        let fetchRequest = NSFetchRequest<LoggerEntity>(entityName: self.entityName)
        let oldLogs = try! mainContext.fetch(fetchRequest)
        let newLogs = LoggerEntity(context: mainContext)
        
        newLogs.message = logger.message
        newLogs.level = logger.level
        
        if oldLogs.count >= 1000 {
            self.deleteLogAt(index: 0, deletedData: oldLogs)
        }
        mainContext.insert(newLogs)
        do {
            try mainContext.save()
        } catch {
            fatalError("Can't save logs \(error)")
        }
        
        
        
        
    }
    func fetchLogs(forEntityName entity: String, completion: @escaping ([LoggerEntity]) -> Void) {
        var logs: [LoggerEntity] = []
        let fetchRequest = NSFetchRequest<LoggerEntity>(entityName: self.entityName)
        do {
            logs = try mainContext.fetch(fetchRequest)
            completion(logs)
        } catch {
            fatalError("Can't fetch logs \(error)")
        }
        
        
    }
}
