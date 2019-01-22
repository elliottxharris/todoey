//
//  item.swift
//  todoey
//
//  Created by Elliott Harris on 1/21/19.
//  Copyright © 2019 Elliott. All rights reserved.
//

import UIKit

class Item : Codable {
	var title : String?
	var done : Bool = false
	
	init(itemTitle : String) {
		title = itemTitle
	}
	
}
