//
//  PeopleController.swift
//  Pair Code Challenge
//
//  Created by Travis Sasselli on 8/26/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import Foundation
import CoreData

class PeopleController {
    
    static let sharedController = PeopleController()
    
    let managedObjectContext = Stack.sharedStack.managedObjectContext
    
    var person: [People] {
        let requests = NSFetchRequest(entityName: People.entityName)
        return (try? managedObjectContext.executeFetchRequest(requests)) as? [People] ?? []
    }
    
    // MARK: CRUD funcs 
    
    func createPeople(name: String) {
        let _ = People(name: name)
        savedManagedObjectContext()
    }
    
    func deletePerson(person: People) {
        managedObjectContext.deleteObject(person)
        savedManagedObjectContext()
    }
    
    func savedManagedObjectContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving to ManagedObjectContext: \(error)")
        }
    }
    
    func createPeoplePairs(arrayOfPeople: [People]) -> [(a: String, b: String?)] {
        var people = arrayOfPeople.flatMap { $0.name }
        let pair = people.generateRandomPairs()
        return pair
    }
}

// MARK: Random Pair Generation

extension Array where Element:Hashable {
    
    mutating func generateRandomPairs() -> [(a: Element, b: Element?)] {
        var newArray: [(a: Element, b: Element?)] = []
        while self.count > 0 {
            var tuple: (a: Element, b: Element?)
            let randomIndexing = Int(arc4random_uniform(UInt32(self.count)))
            if self.count == 2 {
                tuple = (self[randomIndexing], nil)
                self.removeAtIndex(randomIndexing)
                newArray.append(tuple)
            } else {
                tuple = (self[randomIndexing], nil)
                self.removeAtIndex(randomIndexing)
                let newRandomIndex = Int(arc4random_uniform(UInt32(self.count)))
                tuple.b = self[newRandomIndex]
                self.removeAtIndex(newRandomIndex)
                newArray.append(tuple)
            }
            return newArray
        }
    }
}