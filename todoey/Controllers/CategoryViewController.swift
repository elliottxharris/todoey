//
//  CategoryViewController.swift
//  todoey
//
//  Created by Elliott Harris on 1/24/19.
//  Copyright © 2019 Elliott. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

	var categoryArray = [Category]()
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		loadItems()
	}
	
	//MARK: - TableView Datasource Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categoryArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "Category")
		
		
		
		cell.textLabel?.text = categoryArray[indexPath.row].name
		
		return cell
	}
	
	//MARK: - TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "goToItems", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let desinationVC = segue.destination as! ToDoListViewController
		
		if let indexPath = tableView.indexPathForSelectedRow {
			desinationVC.selectedCategory = categoryArray[indexPath.row]
		}
		
	}
	
	//MARK: - Data Methods
	
	func saveData() {
		do {
			try context.save()
		} catch {
			print("Error saving data \(error)")
		}
		
		tableView.reloadData()
	}
	
	func loadItems(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
		
		do {
			categoryArray = try context.fetch(request)
		} catch {
			print("Error fetching data \(error)")
		}
		
		tableView.reloadData()
	}
	
	//MARK: - Add New Categories
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
		let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
			let newCategory = Category(context: self.context)
			newCategory.name = textField.text!
			
			self.categoryArray.append(newCategory)
			
			self.saveData()
		}
		
		alert.addTextField(configurationHandler: { (alertTextField) in
			alertTextField.placeholder = "Add New Category"
			textField = alertTextField
		})
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
		
	}
}
