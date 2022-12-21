import Foundation

class FoodDatabaseModel: Hashable {
    static func == (lhs: FoodDatabaseModel, rhs: FoodDatabaseModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var id = UUID()
    let mealID: Int32
    let mealTitle: String
    let mealReadyInMinutes: Int16
    let mealServings: Int16
    let mealImage: String
    let mealSummary: String
    let isFavourited: Bool
    let mealInstructions: [String]
    let mealIngredients: [String]

    init(mealID: Int32, mealTitle: String, mealReadyInMinutes: Int16, mealServings: Int16, mealImage: String, mealSummary: String, isFavourited: Bool, mealInstructions: [String], mealIngredients: [String]) {
        self.mealID = mealID
        self.mealTitle = mealTitle
        self.mealReadyInMinutes = mealReadyInMinutes
        self.mealServings = mealServings
        self.mealImage = mealImage
        self.mealSummary = mealSummary
        self.isFavourited = isFavourited
        self.mealInstructions = mealInstructions
        self.mealIngredients = mealIngredients
    }
}
