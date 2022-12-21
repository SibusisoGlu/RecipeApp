import Foundation

class FoodDetailModel: Hashable {
    static func == (lhs: FoodDetailModel, rhs: FoodDetailModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var id = UUID()
    var foodId: Int
    var foodTitle: String
    var foodReadyInMinutes, foodServings: Int
    var foodImage: String
    var foodSummary: String
    var foodSteps: [Step]
    var isFavourite: Bool = false

    init(foodId: Int, title: String, readyInMinutes: Int, servings: Int, image: String, summary: String, steps: [Step], isFavourite: Bool = false) {
        self.foodId = foodId
        self.foodTitle = title
        self.foodReadyInMinutes = readyInMinutes
        self.foodServings = servings
        self.foodImage = image
        self.foodSummary = summary
        self.foodSteps = steps
        self.isFavourite = isFavourite
    }
}
