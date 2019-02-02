//
//  Item.swift
//  todoey
//
//  Created by Elliott Harris on 1/25/19.
//  Copyright © 2019 Elliott. All rights reserved.
//

import UIKit
import RealmSwift

class Item: Object {
	@objc dynamic var title = ""
	@objc dynamic var dateCreated : Date?
	@objc dynamic var done = false
	var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
	
	
}
