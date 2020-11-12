//
//  ViewController3.swift
//  PocketChef
//
//  Created by Jonathan Borden on 10/29/20.
//  Copyright © 2020 Max Lattermann. All rights reserved.
//

import UIKit
import CoreData

class ViewController3: UIViewController, UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return items!.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
                   -> UITableViewCell {

        let Item = items![indexPath.row]
      let cell =
        tableView.dequeueReusableCell(withIdentifier: "Cell",
                                      for: indexPath)
      cell.textLabel?.text =
        Item.value(forKeyPath: "name") as? String
      return cell
    }
    

    @IBOutlet weak var tableview: UITableView!
    //Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //Data for the table
    var items:[Ingredient]?
//    var items: [NSManagedObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.dataSource = self
        tableview.delegate = self

        //Get items from Core data
        fetchIngredient()
    }
    func fetchIngredient() {
        // Fetch the data from core data to display in the tableview
        do{
            self.items = try context.fetch(Ingredient.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
        catch{

        }
    }

//    override func viewDidLoad() {
//      super.viewDidLoad()
//
//      title = "My Grocery List"
//      tableview.register(UITableViewCell.self,
//        forCellReuseIdentifier: "Cell")
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//      super.viewWillAppear(animated)
//
//      guard let appDelegate =
//        UIApplication.shared.delegate as? AppDelegate else {
//          return
//      }
//
//      let managedContext =
//        appDelegate.persistentContainer.viewContext
//
//      let fetchRequest =
//        NSFetchRequest<NSManagedObject>(entityName: "GroceryList")
//
//      do {
//        items = try managedContext.fetch(fetchRequest)
//      } catch let error as NSError {
//        print("Could not fetch. \(error), \(error.userInfo)")
//      }
//    }
    
    @IBAction func addTapped(_ sender:UIBarButtonItem){
        //create alert
        
        let alert = UIAlertController(title: "Add Item", message: "What is your item?", preferredStyle: .alert)
        alert.addTextField()
        
        //configure button handler
        let submitButton = UIAlertAction(title:"Add",style: .default){ [unowned self] action in //(action) in
            
            // get the textfield for the alert
            
            let textfield = alert.textFields![0]

            //create a ingredient object

            let newIngredient = Ingredient(context: self.context)
            newIngredient.name = textfield.text
            newIngredient.amount = 20
            newIngredient.unitOfMeasure = "pounds"

//            save the data

            do{
                try self.context.save()
            }
            catch{

            }
            // re-fetch the data
            self.fetchIngredient()
            
//            guard let textField = alert.textFields?.first,
//              let ingredientToSave = textField.text else {
//                return
//            }
//
//            self.save(name: ingredientToSave)
//            self.tableview.reloadData()
//
//        }
        //add button
//        alert.addAction(submitButton)

        //show alert
        self.present(alert, animated: true, completion: nil)

    }
        
//        let cancelAction = UIAlertAction(title: "Cancel",
//                                         style: .cancel)
//
//        alert.addTextField()
//
//        alert.addAction(submitButton)
//        alert.addAction(cancelAction)
//
//        present(alert, animated: true)
//      }
      
//      func save(name: String) {
//
//        guard let appDelegate =
//          UIApplication.shared.delegate as? AppDelegate else {
//          return
//        }
//
//        let managedContext =
//          appDelegate.persistentContainer.viewContext
//
//        let entity =
//          NSEntityDescription.entity(forEntityName: "GroceryList",
//                                     in: managedContext)!
//
//        let ingr = NSManagedObject(entity: entity,
//                                     insertInto: managedContext)
//
//        ingr.setValue(name, forKeyPath: "name")
//
//        do {
//          try managedContext.save()
//          items.append(ingr)
//        } catch let error as NSError {
//          print("Could not save. \(error), \(error.userInfo)")
//        }
//      }
      

  }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

extension ViewController3: UITableViewDataSource{
    
//    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int{
//        //return the number of people
//        return self.items?.count ?? 0
//    }
//
//    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        //Get ingredient from array and set the label
//        let ingredient = self.items![indexPath.row]
//        cell.textLabel?.text = ingredient.name
//
//        return cell
//    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            items.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }

    func tableView(_ tableView: UITableView,didSelectRowAt indexPath:IndexPath){
        //Selected Ingredient
        let ingredient = self.items![indexPath.row]

        //Create alert
        let alert = UIAlertController(title: "Edit Ingredient", message: "Edit Name", preferredStyle: .alert)
        alert.addTextField()

        let textfield = alert.textFields![0]
        textfield.text = ingredient.name

        //Configure button handler

        _ = UIAlertAction(title: "Save", style: .default){ (action) in
          //get the textfield for the alert
            let textfield = alert.textFields![0]

            //edit name property of ingredient object
            ingredient.name = textfield.text

            //save the data
            do{
                 try self.context.save()
            }
            catch{

            }
            //re-fetch the data
            self.fetchIngredient()
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{


            //create swipe action

        let action = UIContextualAction(style: .destructive, title: "Delete") { (acction,view, completionHandler) in
            // which ingredient to remove
            let ingredientToRemove = self.items![indexPath.row]

            //remove the ingredient
            self.context.delete(ingredientToRemove)

            //save the data
            do{
                try self.context.save()
            }
            catch{
            }

            // re-fetch data
            self.fetchIngredient()
        }

            // return swipe actions
            return UISwipeActionsConfiguration(actions: [action])


        }
    
}
