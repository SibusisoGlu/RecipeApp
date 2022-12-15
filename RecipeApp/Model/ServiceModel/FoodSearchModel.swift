import Foundation
class FoodSearchModel: Hashable {
    static func == (lhs: FoodSearchModel, rhs: FoodSearchModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var id = UUID()
    var foodTitle: String
    var foodReadyInMinutes: Int
    var foodImage: String

    init(title: String, readyInMinutes: Int, image: String) {
        self.foodTitle = title
        self.foodReadyInMinutes = readyInMinutes
        self.foodImage = image
    }
}
