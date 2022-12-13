import Foundation

class FoodModel {
    var foodId: Int
    var foodTitle: String
    var foodReadyInMinutes, foodServings: Int
    var foodImage: String
    var foodSummary: String
    var foodSteps: [Step]

    init(id: Int, title: String, readyInMinutes: Int, servings: Int, image: String, summary: String, steps: [Step]) {
        self.foodId = id
        self.foodTitle = title
        self.foodReadyInMinutes = readyInMinutes
        self.foodServings = servings
        self.foodImage = image
        self.foodSummary = summary
        self.foodSteps = steps
    }
}
