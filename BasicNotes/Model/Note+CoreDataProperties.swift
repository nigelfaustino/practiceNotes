//
//  Note+CoreDataProperties.swift
//  BasicNotes
//
//  Created by NIGEL FAUSTINO on 2/19/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var date: Date?

}
