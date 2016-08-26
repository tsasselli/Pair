//
//  People.swift
//  Pair Code Challenge
//
//  Created by Travis Sasselli on 8/26/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import Foundation
import CoreData


class People: NSManagedObject {

    static let entityName = "People"
    
    convenience init (name: String, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        let entities = NSEntityDescription.entityForName(People.entityName, inManagedObjectContext: context)!
        self.init(entity: entities, insertIntoManagedObjectContext: context)
        self.name = name
    }
}



