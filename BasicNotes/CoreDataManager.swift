//
//  CoreDataManager.swift
//  BasicNotes
//
//  Created by NIGEL FAUSTINO on 2/19/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()

    func fetch() -> [Note]? {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return nil }

        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            return fetchedResults
        } catch {
            return nil
        }
    }


    func create() -> Note? {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            var newObject = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
            return newObject
        }
        return nil
    }

    func save() {
        if let context = UIApplication.shared.delegate as? AppDelegate {
            context.saveContext()
        }
    }
}

