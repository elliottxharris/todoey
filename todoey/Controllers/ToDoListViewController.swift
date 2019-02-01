//
//  ViewController.swift
//  todoey
//
//  Created by Elliott Harris on 1/9/19.
//  Copyright © 2019 Elliott. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

	var items : Results<Item>?
	let realm = try! Realm()
	
	var selectedCategory : Category? {
		didSet {
			loadItems()
		}
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		loadItems()
		
	}
	
	//MARK: - TableView Datasource Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items?.count ?? 1
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
		
		if let item = items?[indexPath.row] {
			cell.textLabel?.text = item.title
			
			cell.accessoryType = item.done ? .checkmark : .none
		} else {
			cell.textLabel?.text = "No Items Added"
		}
		
		return cell
	}
	
	//MARK: - TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		if let item = items?[indexPath.row] {
			do {
				try realm.write {
					item.done = !item.done
				}
			} catch {
				print("Error updating \(error)")
			}
		}
		
		tableView.reloadData()

		tableView.deselectRow(at: indexPath, animated: true)
	}
	//MARK: - Add New Items
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			
			if let currentCategory = self.selectedCategory {
				do {
					try self.realm.write {
						let newItem = Item()
						newItem.title = textField.text!
						currentCategory.items.append(newItem)
					}
				} catch {
					print("Error saving new item \(error)")
				}
			}
			self.tableView.reloadData()
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new item"
			textField = alertTextField
		}
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	//MARK: - Save New Items
	
	func loadItems() {

		items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

		tableView.reloadData()
	}
}

//MARK: - Search Bar Methods
//extension ToDoListViewController : UISearchBarDelegate {
//
//	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//		if searchBar.text?.count == 0 {
//			loadItems()
//
//			DispatchQueue.main.async {
//				searchBar.resignFirstResponder()
//			}
//		} else {
//
//			let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//			let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//			request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//			loadItems(with: request, predicate: predicate)
//		}
//
//	}
//
//}
