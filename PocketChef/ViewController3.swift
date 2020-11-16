//
//  ViewController3.swift
//  PocketChef
//
//  Created by Jonathan Borden on 10/29/20.
//  Copyright © 2020 Max Lattermann. All rights reserved.
//

import UIKit
import CoreData

class ViewController3: UIViewController {

    @IBOutlet weak var tablView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var groceries: [GroceryList]?
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
        tablView.dataSource = self
        tablView.delegate = self
        
        fetchGroceries()
    }
    
    func fetchGroceries() {
        do{
            self.groceries = try context.fetch(GroceryList.fetchRequest())
            
            DispatchQueue.main.async {
                self.tablView.reloadData()
            }
        }
        catch{
            
        }
    }
    
    @IBAction func addTapped(_ sender:UIBarButtonItem){
        //create alert
        
        let alert = UIAlertController(title: "Add Item", message: "What is your item?", preferredStyle: .alert)
        alert.addTextField()
        
        //configure button handler
        let submitButton = UIAlertAction(title:"Add",style: .default){ action in
            
            let textfield = alert.textFields![0]

            //create a ingredient object

            let newGrocery = GroceryList(context: self.context)
            newGrocery.name = textfield.text
            
            do{
                try self.context.save()
            }
            catch{

            }
            // re-fetch the data
            self.fetchGroceries()
        }
        //add button
        alert.addAction(submitButton)
        //show alert
        self.present(alert, animated: true, completion: nil)

    }
      

  }
    
    // MARK: - Navigation
extension ViewController3: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int{
        //return the number of people
        return self.groceries?.count ?? 0
    }

    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //Get ingredient from array and set the label
        let rec = self.groceries![indexPath.row]
        cell.textLabel?.text = rec.name
        return cell
    }

    func tableView(_ tableView: UITableView,didSelectRowAt indexPath:IndexPath){
        //Selected Ingredient
        let groc = self.groceries![indexPath.row]

        //Create alert
        let alert = UIAlertController(title: "Edit Item", message: "Edit Name", preferredStyle: .alert)
        alert.addTextField()

        let textfield = alert.textFields![0]
        textfield.text = groc.name

        //Configure button handler
        let saveButton = UIAlertAction(title: "Save", style: .default){ (action) in
          //get the textfield for the alert
            let textfield = alert.textFields![0]

            //edit name property of ingredient object
            groc.name = textfield.text

            //save the data
            do{
                 try self.context.save()
            }
            catch{

            }
            //re-fetch the data
            self.fetchGroceries()
        }
        alert.addAction(saveButton)
        
        self.present(alert, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
            
        //create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (acction,view, completionHandler) in
            // which ingredient to remove
            let itemToRemove = self.groceries![indexPath.row]

            //remove the ingredient
            self.context.delete(itemToRemove)

            //save the data
            do{
                try self.context.save()
            }
            catch{
            }
            // re-fetch data
            self.fetchGroceries()
        }
            // return swipe actions
            return UISwipeActionsConfiguration(actions: [action])
        }
}
