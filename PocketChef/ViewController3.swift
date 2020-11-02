//
//  ViewController3.swift
//  PocketChef
//
//  Created by Jonathan Borden on 10/29/20.
//  Copyright © 2020 Max Lattermann. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    //Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //Data for the table
    var items:[Ingredient]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableview.dataSource = self
        tableview.delegate = self
        
        //Get items from Core data
        fetchIngredient()
    }
    func fetchIngredient() {
        // Fectch the data from core data to display in the tableview
        do{
            self.items = try context.fetch(Ingredient.fetchRequest())
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        
        }
        catch{
            
        }
    }

    @IBAction func addTapped(_ sender:Any){
        //create alert
        
        let alert = UIAlertController(title: "Add Ingredient", message: "What is your Ingredient", preferredStyle: .alert)
        alert.addTextField()
        
        //configure button handler
        let submitButton = UIAlertAction(title:"Add",style: .default){ (action) in
            
            // get the textfield for the alert
            
            let textfield = alert.textFields![0]
            
            //create a ingredient object
            
            let newIngredient = Ingredient(context: self.context)
            newIngredient.name = textfield.text
            newIngredient.amount = 20
            newIngredient.unitOfMeasure = "pounds"
            
            //save the data
            
            do{
                try self.context.save()
            }
            catch{
                
            }
            // re-fetch the data
            self.fetchIngredient()
            
            
        }
        //add button
        alert.addAction(submitButton)
        
        //show alert
        self.present(alert, animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ViewController3: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int{
        //return the number of people
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        //Get ingredient from array and set the label
        let ingredient = self.items![indexPath.row]
        cell.textLabel?.text = ingredient.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath:IndexPath){
        //Selected Ingredient
        let ingredient = self.items![indexPath.row]
        
        //Create alert
        let alert = UIAlertController(title: "Edit Ingredient", message: "Edit Name", preferredStyle: .alert)
        alert.addTextField()
        
        let textfield = alert.textFields![0]
        textfield.text = ingredient.name
        
        //Configure button handler
        
        let saveButton = UIAlertAction(title: "Save", style: .default){ (action) in
          //get the textfield for the alert
            let textfield = alert.textFields![0]
            
            // edit name property of ingredient object
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
}
