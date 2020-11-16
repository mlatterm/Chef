//
//  UserViewController.swift
//  PocketChef
//
//  Created by Jonathan Borden on 10/19/20.
//  Copyright © 2020 Max Lattermann. All rights reserved.
//

import UIKit
import CoreData

class UserViewController: UIViewController {
 
    @IBOutlet weak var GroceryList: UITableView!
    
    var ingredients: [String] = []
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      title = "My Grocery List"
      GroceryList.register(UITableViewCell.self,
        forCellReuseIdentifier: "Cell")
    }
    
    // Implement the addName IBAction
    @IBAction func addIngredient(_ sender: UIBarButtonItem) {
      
      let alert = UIAlertController(title: "New Ingredient",
                                    message: "Add a new ingredient",
                                    preferredStyle: .alert)
      
      let saveAction = UIAlertAction(title: "Save",
                                     style: .default) {
        [unowned self] action in
                                      
        guard let textField = alert.textFields?.first,
          let nameToSave = textField.text else {
            return
        }
        
        self.ingredients.append(nameToSave)
        self.GroceryList.reloadData()
      }
      
      let cancelAction = UIAlertAction(title: "Cancel",
                                       style: .cancel)
      
      alert.addTextField()
      
      alert.addAction(saveAction)
      alert.addAction(cancelAction)
      
      present(alert, animated: true)
    }
    

}

// MARK: - UITableViewDataSource
extension UserViewController: UITableViewDataSource {
  
    func tableView(_ _tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return ingredients.count
  }
  
    func tableView(_ _tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
                 -> UITableViewCell {

    let cell =
      _tableView.dequeueReusableCell(withIdentifier: "Cell",
                                    for: indexPath)
    cell.textLabel?.text = ingredients[indexPath.row]
    return cell
  }
    

}
