//
//  RecipeModel.swift
//  PocketChef
//
//  Created by John Corley on 11/10/20.
//  Copyright © 2020 Max Lattermann. All rights reserved.
//

import SwiftUI

// MARK: - RECIPE MODEL

struct Recipe: Identifiable {
    var id = UUID()
    var title: String
    var headline: String
    var image: String
    var rating: Int
    var serves: Int
    var prepTime: Int
    var cookTime: Int
    var instructions: [String]
    var ingredients: [String]
    
}
