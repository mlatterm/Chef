//
//  RecipeCardView.swift
//  PocketChef
//
//  Created by John Corley on 11/10/20.
//  Copyright © 2020 Max Lattermann. All rights reserved.
//

import SwiftUI
// MARK: -PROPERTIES

struct RecipeCardView: View {
    
    var recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // CARD IMAGE
            Image(recipe.image)
                .resizable()
                .scaledToFit()
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color("ColorBlackTransparentLight"), radius: 8, x: 0, y: 0)
     
        
        
        VStack(alignment: .leading, spacing: 12) {
            // TITLE
            Text(recipe.title)
                .font(.system(.title, design: .serif))
            // HEADLINE
            Text(recipe.headline)
                .font(.system(.body, design: .serif))
                .foregroundColor(Color.gray)
                .italic()
            // RATING
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {
                ForEach(1...(recipe.rating), id: \.self) { _ in
            Image(systemName: "star.fill")
                .font(.body)
                .foregroundColor(Color.yellow)
            }
        }
            // COOKING
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 12) {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 2) {
                    Image(systemName: "person.2")
                    Text("Servings: \(recipe.serves)")
                }
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 2) {
                    Image(systemName: "clock")
                    Text("Prep Time: \(recipe.prepTime)")
                }
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 2) {
                    Image(systemName: "flame")
                    Text("Cook Time: \(recipe.cookTime)")
                }
            }
            
            .font(.footnote)
            .foregroundColor(Color.gray)
        }
        .padding()
        .padding(.bottom, 12)
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(recipe: recipesData[0])
            .previewLayout(.sizeThatFits)
    }
}
