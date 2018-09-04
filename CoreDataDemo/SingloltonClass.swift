//
//  SingloltonClass.swift
//  CoreDataDemo
//
//  Created by VVDN on 26/07/18.
//  Copyright © 2018 AppDmmo. All rights reserved.
//

import UIKit
import CoreData

class SingloltonClass: NSObject {
    
    static let sharedObject = SingloltonClass()
    
    override init(){}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // save dictionary in core data
    func saveUser(dictionary: Dictionary<String, Any>){
        let context = persistentContainer.viewContext
        context.performAndWait({
            let addressDict = dictionary["address"] as! [String : Any]
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
            let userAddress = NSEntityDescription.insertNewObject(forEntityName: "Address", into: context) as! Address
            
            newUser.id = dictionary["id"] as? String
            newUser.name = dictionary["name"] as? String
            newUser.email = dictionary["email"] as? String
            newUser.username = dictionary["username"] as? String
            
            userAddress.city = addressDict["city"] as? String
            userAddress.suite = addressDict["suite"] as? String
            userAddress.street = addressDict["street"] as? String
            userAddress.zipcode = addressDict["zipcode"] as? String
            
            newUser.userAddress = userAddress
            self.saveContext()
        })
    }
    
    // fetch all Data
    func fatchAllData() -> [User] {
        let context = persistentContainer.viewContext
        var allDataArray : [User] = []
        do {
            allDataArray = try context.fetch(User.fetchRequest())
        } catch  {
            print("error")
        }
        return allDataArray
    }
    
    
    //MARK :- delete data
    func deletData( user: User) {
    let context = persistentContainer.viewContext
       var allDataArray : [User] = []
        allDataArray = self.fatchAllData()
        print("Before>>>>>>>>>>>",allDataArray)
        context.delete(user)
        allDataArray = self.fatchAllData()
         print("After>>>>>>>>>>>",allDataArray)
      self.saveContext()
    }
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }
    
}

