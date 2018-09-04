//
//  NetworkClass.swift
//  CoreDataDemo
//
//  Created by VVDN on 26/07/18.
//  Copyright © 2018 AppDmmo. All rights reserved.
//

import UIKit

class NetworkClass: NSObject {
    
    typealias completionhadler = ([User]?, NSError?) ->Void
    
    class func callApiWithBlock(funcComplition:@escaping completionhadler)  {
        
        //Implementing URLSession
        let urlString = "https://jsonplaceholder.typicode.com/users" //json start from array Url
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                funcComplition(nil,error as NSError?);
                
            }
            guard let data = data else { return }
            
            do {
                //using when json start from Array
                if let json = try? JSONSerialization.jsonObject(with: data, options: []){
                    if let jsonArray = json as? [[String: Any]] {
                        print(jsonArray)
                        //Mark :- with loop itrate Array
                        for item in jsonArray{
                            SingloltonClass.sharedObject.saveUser(dictionary: item )
                        }
                        let array = SingloltonClass.sharedObject.fatchAllData() 
                        funcComplition(array , error as NSError?);
                    }
                }
            }
            
            }.resume()
    }
}

