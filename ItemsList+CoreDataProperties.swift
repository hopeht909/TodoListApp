//
//  ItemsList+CoreDataProperties.swift
//  TodoListApp
//
//  Created by admin on 16/12/2021.
//
//

import Foundation
import CoreData


extension ItemsList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemsList> {
        return NSFetchRequest<ItemsList>(entityName: "ItemsList")
    }

    @NSManaged public var itemTitle: String?
    @NSManaged public var itemNotes: String?
    @NSManaged public var dueDate: String?

}

extension ItemsList : Identifiable {

}
