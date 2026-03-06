import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @State private var expandedSections = [true, true]
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            List {
                Section(isExpanded: $expandedSections[0]) { ForEach(recipe.ingredients.indices, id: \.self) { index in
                    let ingredient = recipe.ingredients[index]
                    Text(ingredient.description)
                        .foregroundColor(listTextColor)
                }
                } header: {
                    Text("Ingredients")
                }
                .listRowBackground(listBackgroundColor)
                
                Section(isExpanded: $expandedSections[1]) {
                    ForEach(recipe.directions.indices, id: \.self) { index in
                        let direction = recipe.directions[index]
                        HStack {
                            Text("\(index + 1). ").bold()
                            Text("\(direction.isOptional ? "(Optional) " : "")"
                                 + "\(direction.description)")
                        } .foregroundColor(listTextColor)
                    }
                } header: {
                    Text("Directions")
                }
                .listRowBackground(listBackgroundColor)
            }
            .listStyle(.sidebar)
        }
        .navigationTitle(recipe.mainInformation.name)
    }
}

#Preview {
    @Previewable @State var recipe = Recipe.testRecipes[0]
    NavigationView {
        RecipeDetailView(recipe: recipe)
    }
}
