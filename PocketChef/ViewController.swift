//
//  ViewController.swift
//  PocketChef
//
//  Created by Max Lattermann on 9/21/20.
//  Copyright © 2020 Max Lattermann. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var ingredients: [NSManagedObject] = []
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      title = "My Pantry"
      tblView.register(UITableViewCell.self,
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
        NSFetchRequest<NSManagedObject>(entityName: "Ingredient")
      
      do {
        ingredients = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }

    
    // Implement the addName IBAction
    @IBAction func addIngredient(_ sender: UIBarButtonItem) {
      
      let alert = UIAlertController(title: "New Ingredient",
                                    message: "Add a new ingredient",
                                    preferredStyle: .alert)
      
        let saveAction = UIAlertAction(title: "Save", style: .default) {
          [unowned self] action in
          
          guard let textField = alert.textFields?.first,
            let ingredientToSave = textField.text else {
              return
          }
          
          self.save(name: ingredientToSave)
          self.tblView.reloadData()
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
        NSEntityDescription.entity(forEntityName: "Ingredient",
                                   in: managedContext)!
      
      let ingr = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      ingr.setValue(name, forKeyPath: "name")
      
      do {
        try managedContext.save()
        ingredients.append(ingr)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    

}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return ingredients.count
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
                 -> UITableViewCell {

    let Ingredient = ingredients[indexPath.row]
    let cell =
      tableView.dequeueReusableCell(withIdentifier: "Cell",
                                    for: indexPath)
    cell.textLabel?.text =
      Ingredient.value(forKeyPath: "name") as? String
    return cell
  }
}


