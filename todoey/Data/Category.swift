//
//  Category.swift
//  todoey
//
//  Created by Elliott Harris on 1/25/19.
//  Copyright © 2019 Elliott. All rights reserved.
//

import UIKit
import RealmSwift

class Category : Object {
	@objc dynamic var name = ""
	let items = List<Item>()
	
}
