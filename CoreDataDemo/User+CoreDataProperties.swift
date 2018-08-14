//
//  User+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by VVDN on 27/07/18.
//  Copyright © 2018 AppDmmo. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var username: String?
    @NSManaged public var userAddress: Address?

}
