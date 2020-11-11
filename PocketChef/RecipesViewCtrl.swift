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
    
    var recipes: [NSManagedObject] = []
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      title = "Recipes"
      table.register(UITableViewCell.self,
        forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Recipes")
        
        do {
          recipes = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
      }


    
  // Implement the addName IBAction
    @IBAction func addRecipe(_ sender: UIBarButtonItem) {
      
      let alert = UIAlertController(title: "New Recipe",
                                    message: "Enter name of a new Recipe",
                                    preferredStyle: .alert)
      
        let saveAction = UIAlertAction(title: "Save", style: .default) {
          [unowned self] action in
          
          guard let textField = alert.textFields?.first,
            let recipeToSave = textField.text else {
              return
          }
          
          self.save(name: recipeToSave)
          self.table.reloadData()
        }
      
      let cancelAction = UIAlertAction(title: "Cancel",
                                       style: .cancel)
      
      alert.addTextField()
      
      alert.addAction(saveAction)
      alert.addAction(cancelAction)
      
      present(alert, animated: true)
    }
    
    func save(name: String) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      let entity =
        NSEntityDescription.entity(forEntityName: "Recipes",
                                   in: managedContext)!
      
      let rec = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      rec.setValue(name, forKeyPath: "name")
      
      do {
        try managedContext.save()
        recipes.append(rec)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    

}

// MARK: - UITableViewDataSource
extension RecipesViewCtrl: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return recipes.count
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
                 -> UITableViewCell {

    let Recipes = recipes[indexPath.row]
    let cell =
      tableView.dequeueReusableCell(withIdentifier: "Cell",
                                    for: indexPath)
    cell.textLabel?.text =
      Recipes.value(forKeyPath: "name") as? String
    return cell
  }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            recipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
