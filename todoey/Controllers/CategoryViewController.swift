//
//  CategoryViewController.swift
//  todoey
//
//  Created by Elliott Harris on 1/24/19.
//  Copyright © 2019 Elliott. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
	
	let realm = try! Realm()

	var categories : Results<Category>?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		loadCategoriess()
		
		tableView.separatorStyle = .none
	}
	
	//MARK: - TableView Datasource Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categories?.count ?? 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = super.tableView(tableView, cellForRowAt: indexPath)
		
		cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added"
		
		cell.backgroundColor = UIColor.randomFlat
		
		return cell
	}
	
	//MARK: - TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "goToItems", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let desinationVC = segue.destination as! ToDoListViewController
		
		if let indexPath = tableView.indexPathForSelectedRow {
			desinationVC.selectedCategory = categories?[indexPath.row]
		}
		
	}
	
	//MARK: - Data Methods
	
	func save(category : Category) {
		do {
			try realm.write {
				realm.add(category)
			}
		} catch {
			print("Error saving data \(error)")
		}
		
		tableView.reloadData()
	}
	
	func loadCategoriess() {
		
		categories = realm.objects(Category.self)
		
		tableView.reloadData()
	}
	
	override func updateModel(at indexPath: IndexPath) {
		if let categoryForDeletion = self.categories?[indexPath.row] {
			do {
				try self.realm.write {
					self.realm.delete(categoryForDeletion)
				}
			} catch {
				print("Error deletinv \(error)")
			}
		}
	}
	
	//MARK: - Add New Categories
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
		let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
			let newCategory = Category()
			newCategory.name = textField.text!
			
			self.save(category: newCategory)
		}
		
		alert.addTextField(configurationHandler: { (alertTextField) in
			alertTextField.placeholder = "Add New Category"
			textField = alertTextField
		})
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
		
	}
}

