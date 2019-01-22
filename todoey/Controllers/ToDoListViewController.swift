//
//  ViewController.swift
//  todoey
//
//  Created by Elliott Harris on 1/9/19.
//  Copyright © 2019 Elliott. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

	var itemArray = [Item]()
	
	let defaults = UserDefaults.standard
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let newItem = Item(itemTitle: "item")
		itemArray.append(newItem)
		
		if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
			itemArray = items
		}
		
	}
	
	//MARK: - TableView Datasource Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
		
		let item = itemArray[indexPath.row]
		
		cell.textLabel?.text = item.title
		
		cell.accessoryType = item.done ? .checkmark : .none
		
		return cell
	}
	
	//MARK: - TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		
		tableView.reloadData()
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	//MARK: - Add New Items
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			self.itemArray.append(Item(itemTitle: textField.text!))
			
			self.defaults.set(self.itemArray, forKey: "ToDoListArray")
			
			self.tableView.reloadData()
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new item"
			textField = alertTextField
		}
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
}

