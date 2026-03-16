import SwiftUI

struct ModifyDirectionView: ModifyComponentView {
    @Binding var direction: Direction
    let createAction: (Direction) -> Void
    
    init(component: Binding<Direction>, createAction: @escaping (Direction) -> Void) {
        self._direction = component
        self.createAction = createAction
    }
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    @Environment(\.presentationMode) private var mode
    @EnvironmentObject private var recipeData: RecipeData
    
    var body: some View {
        Form {
            TextField("",
                      text: $direction.description,
                      prompt: Text("Direction Description")
                .foregroundColor(listTextColor)
                      )
                .listRowBackground(listBackgroundColor)
            Toggle("Optional", isOn: $direction.isOptional)
                .listRowBackground(listBackgroundColor)
            HStack {
                Spacer()
                Button("Save") {
                    createAction(direction)
                    mode.wrappedValue.dismiss()
                }
                Spacer()
            }.listRowBackground(listBackgroundColor)
        }
        .foregroundColor(listTextColor)
    }
}

#Preview {
    @Previewable @State var recipe = Recipe.testRecipes[0]
    NavigationView {
        ModifyDirectionView(component: $recipe.directions[0]) { direction in print(direction)
        }
    }
}
