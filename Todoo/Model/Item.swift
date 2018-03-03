//
//  Item.swift
//  Todoo
//
//  Created by babu on 03/03/18.
//  Copyright © 2018 Bobzzzdev. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
