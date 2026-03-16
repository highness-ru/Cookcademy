import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: Recipe
    @State private var expandedSections = [true, true]
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    
    @State private var isPresenting = false
    @EnvironmentObject private var recipeData: RecipeData
    
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
                        if direction.isOptional && hideOptionalSteps {
                            EmptyView()
                        } else {
                            HStack {
                                let index = recipe.index(of: direction, excludingOptionalDirections: hideOptionalSteps) ?? 0
                                Text("\(index + 1). ").bold()
                                Text("\(direction.isOptional ? "(Optional) " : "")"
                                     + "\(direction.description)")
                            } .foregroundColor(listTextColor)
                        }
                    }
                } header: {
                    Text("Directions")
                }
                .listRowBackground(listBackgroundColor)
            }
            .listStyle(.sidebar)
        }
        .navigationTitle(recipe.mainInformation.name)
        .toolbar {
            ToolbarItem {
                HStack {
                    Button("Edit") {
                        isPresenting = true
                    }
                    Button(action: {
                        recipe.isFavorite.toggle()
                    }) {
                        Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                    }
                }
            }
            ToolbarItem(placement: .navigationBarLeading) { Text("") }
        }
        .sheet(isPresented: $isPresenting) {
            NavigationView {
                ModifyRecipeView(recipe: $recipe)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresenting = false
                            }
                        }
                    }
                    .navigationTitle("Edit Recipe")
            } .onDisappear {
                recipeData.saveRecipes()
            }
        }
    }
}

#Preview {
    @Previewable @State var recipe = Recipe.testRecipes[0]
    NavigationView {
        RecipeDetailView(recipe: $recipe)
    }
}
