//
//  ViewController.swift
//  PocketChef
//
//  Created by Max Lattermann on 9/21/20.
//  Copyright © 2020 Max Lattermann. All rights reserved.
//

import UIKit
import CoreData

class RecipesViewCtrl: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var recipes: [Recipes]?
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
        table.dataSource = self
        table.delegate = self
        
        fetchRecipes()
    }
    
    func fetchRecipes() {
        do{
            self.recipes = try context.fetch(Recipes.fetchRequest())
            
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
        catch{
            
        }
    }
    
  // Implement the addName IBAction
    @IBAction func addRecipe(_ sender: UIBarButtonItem) {
      
      let alert = UIAlertController(title: "New Recipe",
                                    message: "Enter name of a new Recipe",
                                    preferredStyle: .alert)
      
        alert.addTextField()
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
          action in
          
            let textfield = alert.textFields![0]
            
            let newRecipe = Recipes(context: self.context)
            newRecipe.title = textfield.text
            
            try! self.context.save()
            
            self.fetchRecipes()
        }
        alert.addAction(saveAction)
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: - UITableViewDataSource
extension RecipesViewCtrl: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return self.recipes?.count ?? 0
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    let cell =
      tableView.dequeueReusableCell(withIdentifier: "Cell",
                                    for: indexPath)
    
    let Recipes = self.recipes![indexPath.row]
    
    cell.textLabel?.text = Recipes.title
    return cell
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rec = self.recipes![indexPath.row]
        
        let alert = UIAlertController(title: "Edit Recipe Name", message: "Edit:", preferredStyle: .alert)
        alert.addTextField()
        
        let textfield = alert.textFields![0]
        textfield.text = rec.title
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
            let textfield = alert.textFields![0]
            
            rec.title = textfield.text
            
            do{
                try self.context.save()
            }catch{
                
            }
            
            self.fetchRecipes()
        }
        
        alert.addAction(saveButton)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            let recipeToRemove = self.recipes![indexPath.row]
            
            self.context.delete(recipeToRemove)
            
            do{
                try self.context.save()
            }catch{
                
            }
            
            self.fetchRecipes()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
