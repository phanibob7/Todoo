//
//  CategoryTableViewController.swift
//  Todoo
//
//  Created by babu on 03/03/18.
//  Copyright © 2018 Bobzzzdev. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        cell.textLabel?.text = categories[indexPath.row].name

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

            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!

            self.categories.append(newCategory)
            self.saveCategories()
        }
        alert.addAction(action)

        alert.addTextField { (field) in
            textField = field
        }

        present(alert, animated: true, completion: nil)
    }

    func saveCategories() {

        do {
            try context.save()
        } catch {
            print("Error sacing category, \(error)")
        }
        tableView.reloadData()
    }

    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {

        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching item array \(error)")
        }

        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as! TodoListViewController).selectedCategory = categories[indexPath.row]
            }
        }
    }
    
}
