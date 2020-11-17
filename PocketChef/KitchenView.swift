//
//  KitchenView.swift
//  PocketChef
//
//  Created by Max Lattermann on 11/16/20.
//  Copyright © 2020 Max Lattermann. All rights reserved.
//

import SwiftUI
import CoreData

class KitchenView: UIViewController{
    
    @IBOutlet weak var recipeView: UITextView!
    
    
    @IBAction func showRecipe(_ sender: Any) {
        recipeView.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeView.isHidden = true
        
        
        //create if else with all the recipe code if(tblView includes eggs){}
        
//        if Ingredient.fetchRequest().contains ("eggs"){
//
//            recipeView.text = ""
//        }else{}
        
        recipeView.text = "No recipe available.\nPlease come back later."
        

    }
}


