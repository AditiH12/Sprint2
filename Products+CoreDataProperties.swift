//
//  Products+CoreDataProperties.swift
//  
//
//  Created by Capgemini-DA073 on 9/27/22.
//
//

import Foundation
import CoreData


extension Products {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Products> {
        return NSFetchRequest<Products>(entityName: "Products")
    }

    @NSManaged public var productName: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var emailIDUser: String?
    @NSManaged public var productImage: String?

}
