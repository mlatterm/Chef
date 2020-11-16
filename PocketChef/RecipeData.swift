//
//  RecipeData.swift
//  PocketChef
//
//  Created by John Corley on 11/10/20.
//  Copyright © 2020 Max Lattermann. All rights reserved.
//

import SwiftUI
import CoreData

// MARK: - RECIPE DATA

let recipesData: [Recipe] = [
    Recipe (
      title: "John’s Dank Egg Salad Recipe",
      headline: "Delicious egg salad made easy!",
      image: "eggSaladSamwich",
      rating: 5,
      serves: 5,
      prepTime: 30,
      cookTime: 16,
      instructions: [
      "After boiling (~10 min) and shelling 8 eggs, separate the yolk from the white, smush it up with a fork, mix all the following stuff with the yolk, then add it back with the chopped white and resume mixing. (feel free garnish it with more paprika when serving it)"
      ],
      ingredients: [
        "1 cup mayonnaise",
        "1.5 teaspoon vinegar",
        "~2 tablespoons of chopped green onion",
        "2 teaspoons of dill relish",
        "2.5 teaspoon Dijon mustard",
        "2/3 teaspoon salt",
        "1/2 teaspoon pepper",
        "1.5 pinch of parsley",
        "A couple dashes of paprika"
      ]
    )
    ]
