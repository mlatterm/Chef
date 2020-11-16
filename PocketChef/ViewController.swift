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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var ingredients: [Ingredient]?
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
        tblView.dataSource = self
        tblView.delegate = self
        
        fetchIngredients()
        
    }
    
    func fetchIngredients() {
        do{
            self.ingredients = try context.fetch(Ingredient.fetchRequest())
            
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
        catch{
            
        }
    }
    
    // Implement the addName IBAction
    @IBAction func addIngredient(_ sender: UIBarButtonItem) { //sender: Any
      
      let alert = UIAlertController(title: "New Ingredient",
                                    message: "Add a new ingredient",
                                    preferredStyle: .alert)
        alert.addTextField()
      
        let submitButton = UIAlertAction(title: "Add", style: .default) {
          action in
          
            let textfield = alert.textFields![0]
            
            let newIngredient = Ingredient(context: self.context)
            newIngredient.name = textfield.text
            newIngredient.amount = 10
            newIngredient.unitOfMeasure = "pounds"
            
            try! self.context.save()
            
            self.fetchIngredients()
        }
        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
    }

}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.ingredients?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    tblView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    let ingredient = self.ingredients![indexPath.row]

    cell.textLabel?.text = ingredient.name
    return cell
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ingredient = self.ingredients![indexPath.row]
        
        let alert = UIAlertController(title: "Edit Ingredient", message: "Edit:", preferredStyle: .alert)
        alert.addTextField()
        
        let textfield = alert.textFields![0]
        textfield.text = ingredient.name
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
            let textfield = alert.textFields![0]
            
            ingredient.name = textfield.text
            
            do{
                try self.context.save()
            }catch{
                
            }
            
            self.fetchIngredients()
        }
        
        alert.addAction(saveButton)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            let ingredientToRemove = self.ingredients![indexPath.row]
            
            self.context.delete(ingredientToRemove)
            
            do{
                try self.context.save()
            }catch{
                
            }
            
            self.fetchIngredients()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
