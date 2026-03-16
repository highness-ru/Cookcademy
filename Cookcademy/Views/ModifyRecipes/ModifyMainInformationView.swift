import SwiftUI

struct ModifyMainInformationView: View {
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    @Binding var mainInformation: MainInformation
    @EnvironmentObject private var recipeData: RecipeData
    
    var body: some View {
        Form {
            TextField("",
                      text: $mainInformation.name,
                      prompt: Text("Recipe Name")
                .foregroundColor(listTextColor)
            )
                .listRowBackground(listBackgroundColor)
            TextField("",
                      text: $mainInformation.author,
                      prompt: Text("Author")
                .foregroundColor(listTextColor)
            )
                .listRowBackground(listBackgroundColor)
            Section(header: Text("Description")) {
                TextEditor(text: $mainInformation.description)
                    .listRowBackground(listBackgroundColor)
            }
            Picker(selection: $mainInformation.category, label:
                    HStack {
                Text("Category")
                Spacer()
                //Text(mainInformation.category.rawValue)
            }) {
                ForEach(MainInformation.Category.allCases,
                        id: \.self) { category in
                    Text(category.rawValue)
                }
            }
            .listRowBackground(listBackgroundColor)
            .pickerStyle(MenuPickerStyle())
        }
        .foregroundColor(listTextColor)
    }
}

#Preview {
    @Previewable @State var mainInformation =  MainInformation(name: "Mutton Stew", description: "I know nothing and even I could cook that", author: "John Snow", category: .lunch)
    @Previewable @State var emptyInformation = MainInformation(name: "", description: "", author: "", category: .breakfast)
    
    ModifyMainInformationView(mainInformation: $mainInformation)
    ModifyMainInformationView(mainInformation: $emptyInformation)
}
