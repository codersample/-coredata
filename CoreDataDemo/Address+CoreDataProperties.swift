//
//  Address+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by VVDN on 27/07/18.
//  Copyright © 2018 AppDmmo. All rights reserved.
//
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var city: String?
    @NSManaged public var street: String?
    @NSManaged public var suite: String?
    @NSManaged public var zipcode: String?

}
