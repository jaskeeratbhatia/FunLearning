//
//  DatabaseManager.swift
//  FunLearning
//
//  Created by Jaskeerat Singh Bhatia on 2018-07-07.
//  Copyright © 2018 jaskeeratbhatia. All rights reserved.
//

import Foundation
import RealmSwift
import  Realm

class DatabaseManager : NSObject {
    
    
    static let shared = DatabaseManager()
    
    private let realm = try! Realm()
    
    private override init() {
        super.init()
    }
    
    func getAllItems() -> [Item]?{
        let items = realm.objects(Item.self)
        return items.map({$0})
    }
    
    func addItem(item: Item){
        
        do{
            try realm.write {
                realm.add(item)
            }
            
        }
        catch{
            print("Error while adding to Item : \(error.localizedDescription)")
        }
        
    }
    
}



