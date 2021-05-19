//
//  DataController.swift
//  MyPortfolioApp
//
//  Created by Rohini Vaidya on 01/05/21.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
    
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, err) in
            if let error = err {
                fatalError("Fatal Error in loading Container \(error.localizedDescription)")
            }
        }
        
    }
    
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        do {
            try dataController.createSampleData()
        }
        catch {
            fatalError("Fatal error in creating sample data")
        }
        return dataController
    }()
    
    func createSampleData() throws {
        let context = container.viewContext
        
        for i in 0..<5 {
            let project = Project(context: context)
            project.title = "Project \(i)"
            project.closed = Bool.random()
            project.creationDate = Date()
            project.items = []
            
            for i in 0..<10 {
                let item = Item(context: context)
                item.title = "Item \(i)"
                item.creationDate = Date()
                item.project = project
                item.priority = Int16.random(in: 1...3)
            }
            
        }
 
        try context.save()
    }
    
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        let context = container.viewContext
        context.delete(object)
    }
    
    func deleteAll() {
        
        let fetchReq1: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        let deleteBatchRequest1 = NSBatchDeleteRequest(fetchRequest: fetchReq1)
        let _ = try? container.viewContext.execute(deleteBatchRequest1)
        
        let fetchReq2: NSFetchRequest<NSFetchRequestResult> = Project.fetchRequest()
        let deleteBatchRequest2 = NSBatchDeleteRequest(fetchRequest: fetchReq2)
        let _ = try? container.viewContext.execute(deleteBatchRequest2)
        
    }
}
