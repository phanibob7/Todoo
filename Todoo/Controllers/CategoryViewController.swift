//
//  CategoryTableViewController.swift
//  Todoo
//
//  Created by babu on 03/03/18.
//  Copyright © 2018 Bobzzzdev. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"

        return cell
    }


    //MARK - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addCategoryClicked(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: "Add category", message: nil, preferredStyle: .alert)

        let action = UIAlertAction(title: "Ok", style: .default) { (action) in

            let newCategory = Category()
            newCategory.name = textField.text!

            self.save(category: newCategory)
        }
        alert.addAction(action)

        alert.addTextField { (field) in
            textField = field
        }

        present(alert, animated: true, completion: nil)
    }

    func save(category: Category) {

        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error sacing category, \(error)")
        }
        tableView.reloadData()
    }

    func loadCategories() {
        categories = realm.objects(Category.self)

        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as! TodoListViewController).selectedCategory = categories?[indexPath.row]
            }
        }
    }
    
}
