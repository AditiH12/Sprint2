//
//  Sprint2+CoreDataProperties.swift
//  
//
//  Created by Capgemini-DA073 on 9/26/22.
//
//

import Foundation
import CoreData


extension Sprint2 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sprint2> {
        return NSFetchRequest<Sprint2>(entityName: "Sprint2")
    }

    @NSManaged public var userName: String?
    @NSManaged public var userEmailID: String?
    @NSManaged public var userMobileNo: String?
    @NSManaged public var userPassword: String?
    @NSManaged public var itemName: String?
    @NSManaged public var itemDescription: String?
    @NSManaged public var itemImage: String?
    @NSManaged public var itemPrice: String?

}
