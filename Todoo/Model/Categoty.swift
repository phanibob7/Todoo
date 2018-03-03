//
//  Categoty.swift
//  Todoo
//
//  Created by babu on 03/03/18.
//  Copyright © 2018 Bobzzzdev. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
