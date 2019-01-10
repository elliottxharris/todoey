//
//  ViewController.swift
//  todoey
//
//  Created by Elliott Harris on 1/9/19.
//  Copyright © 2019 Elliott. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

	let itemArray = ["item1", "item2", "item3"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	//MARK: - TableView Datasource Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
		
		cell.textLabel?.text = itemArray[indexPath.row]
		
		return cell
	}
	
	//MARK: - TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
			tableView.cellForRow(at: indexPath)?.accessoryType = .none
		} else {
			tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
		}
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

