//
//  ViewController.swift
//  todoey
//
//  Created by Elliott Harris on 1/9/19.
//  Copyright © 2019 Elliott. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

	var itemArray = [Item]()
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
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
		
		context.delete(itemArray[indexPath.row])
		
		saveItems()
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	//MARK: - Add New Items
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			
			let newItem = Item(context: self.context)
			newItem.title = textField.text!
			newItem.done = false
			newItem.parentCategory = self.selectedCategory
			
			self.itemArray.append(newItem)
			
			self.saveItems()
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new item"
			textField = alertTextField
		}
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	//MARK: - Save New Items
	func saveItems() {
		
		do {
			try context.save()
		} catch {
			print("Error saving context \(error)")
		}
		
		tableView.reloadData()
	}
	
	func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
		
		let categpryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
		
		if let additionalPredicate = predicate {
			
			request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [additionalPredicate, categpryPredicate])
			
		} else {
			
			request.predicate = categpryPredicate
		}
		
		do {
			itemArray = try context.fetch(request)
		} catch {
			print("Error fetching data \(error)")
		}
		
		tableView.reloadData()
	}
}

//MARK: - Search Bar Methods
extension ToDoListViewController : UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchBar.text?.count == 0 {
			loadItems()
			
			DispatchQueue.main.async {
				searchBar.resignFirstResponder()
			}
		} else {
		
			let request : NSFetchRequest<Item> = Item.fetchRequest()
			
			let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
			
			request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
			
			loadItems(with: request, predicate: predicate)
		}
		
	}
	
}
