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
        
        
        //create if else with all the recipe code if(Ingredients includes eggs){}
        
//        if ourRecipe.contains(eggs.name){
//
//            recipeView.text = ""
//        }else{}
        
//        recipeView.text = "No recipe available.\nPlease come back later."
        
        recipeView.text = "John’s Dank Egg Salad Recipe\n\nRating: 5/5\nServings: 5\nPreparation Time: 30 min\nCook Time: 15 min\n\n1 cup mayonnaise\n1.5 teaspoon vinegar\n~2 tablespoons of chopped green onion\n2 teaspoons of dill relish\n2.5 teaspoon Dijon mustard\n2/3 teaspoon salt\n1/2 teaspoon pepper\n1.5 pinch of parsley\nA couple dashes of paprika\n\nAfter boiling (~10 min) and shelling 8 eggs, separate the yolk from the white, smush it up with a fork, mix all the following stuff with the yolk, then add it back with the chopped white and resume mixing. (feel free garnish it with more paprika when serving it)"
    }
}

