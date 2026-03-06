import SwiftUI

struct RecipeCategoryGridView: View {
    @StateObject private var recipeData = RecipeData()
    
    var body: some View {
        let columns = [GridItem(), GridItem()]
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(MainInformation.Category.allCases,
                            id: \.self) { category in
                        NavigationLink(
                            destination: RecipesListView(category: category)
                                .environmentObject(recipeData),
                            label: {
                                CategoryView(category: category)
                            })
                    }
                })
            }
            .navigationTitle("Categories")
        }
    }
}

struct CategoryView: View {
    let category: MainInformation.Category
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(category.rawValue.uppercased())
                .fontWeight(.black)
                .padding(8)
                .foregroundStyle(.white)
                .background(.black.opacity(0.75))
                .clipShape(.capsule)
                .offset(x: -5, y: -5)
        }
    }
}

#Preview {
    RecipeCategoryGridView()
}
