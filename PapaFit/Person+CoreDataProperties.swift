//
//  Person+CoreDataProperties.swift
//  PapaFit
//
//  Created by Bilven on 03/06/18.
//  Copyright © 2018 Bilven. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var contactno: String?
}
