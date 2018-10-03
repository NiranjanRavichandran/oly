//
//  Record.swift
//  oly
//
//  Created by Niranjan Ravichandran on 9/14/18.
//  Copyright © 2018 Aviato. All rights reserved.
//

import Foundation
import CoreData

struct Record: Codable {
    
    var name: String!
    var timestamp: Date!
    var updatedAt: Date!
    
    init(name: String) {
        self.name = name
        self.timestamp = Date()
        self.updatedAt = Date()
    }
    
    init(managedObject: NSManagedObject) {
        self.name = managedObject.value(forKey: "name") as? String ?? ""
        self.timestamp = managedObject.value(forKey: "timestamp") as? Date
        self.updatedAt = managedObject.value(forKey: "updatedAt") as? Date
    }
    
    func getManagedObject(entity: NSEntityDescription, context: NSManagedObjectContext) -> NSManagedObject {
        let newRecord = NSManagedObject(entity: entity, insertInto: context)
        newRecord.setValue(self.name, forKey: "name")
        newRecord.setValue(self.timestamp, forKey: "timestamp")
        return newRecord
    }
}
