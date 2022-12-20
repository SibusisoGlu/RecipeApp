import Foundation
import UIKit

protocol SearchItemRetreivable {
    var foodInformation: [FoodDetailModel]? { get }
}

protocol FoodInformationDelegate {
    func didRetrieveFoodInformation(foodList: [FoodDetailModel])
}

class RecipeViewModel: FoodInformationDelegate, SearchItemRetreivable {
    var foodInformation: [FoodDetailModel]?
    var delegate: FoodInformationDelegate?

    private let networking = NetworkManager()

    func getRecipeInformation(with foodItem: String) {
        networking.fetchFoodDetails(for: foodItem) { foodData in
            self.foodInformation = foodData ?? []
            self.delegate?.didRetrieveFoodInformation(foodList: self.foodInformation ?? [])
        }
    }

    func didRetrieveFoodInformation(foodList: [FoodDetailModel]) {
        foodInformation = foodList
    }

//    func generateData(with foodStepData: [Step], _ steps: [String], _ ingredients: [String]) {
//        for step in foodStepData {
//            steps.append(step.step ?? "")
//            guard let ingredientData = step.ingredients else { return }
//            for ingredient in ingredientData {
//                ingredients.append(ingredient.name ?? "")
//            }
//        }
//    }

}
