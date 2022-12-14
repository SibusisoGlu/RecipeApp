import Foundation
class FoodSearchModel {
    var foodTitle: String
    var foodReadyInMinutes: Int
    var foodImage: String

    init(title: String, readyInMinutes: Int, image: String) {
        self.foodTitle = title
        self.foodReadyInMinutes = readyInMinutes
        self.foodImage = image
    }
}
