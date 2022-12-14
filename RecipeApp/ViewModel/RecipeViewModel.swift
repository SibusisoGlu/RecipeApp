import Foundation
import UIKit

protocol SearchItemRetreivable {
    var foodInformation: [FoodDetailModel]? { get }
}

class RecipeViewModel: FoodInformationDelegate, SearchItemRetreivable {
    var foodInformation: [FoodDetailModel]?

    private let networking = NetworkManager()

    init() {
        networking.delegate = self
    }

    func getRecipeInformation(with foodItem: String) {
        networking.fetchFoodDetails(for: foodItem) { foodData in
            self.foodInformation = foodData ?? []
        }
    }

    func didRetrieveFoodInformation(foodList: [FoodDetailModel]) {
        foodInformation = foodList
        
    }

    func getSearchResultData() {
        print(foodInformation?[0].foodTitle)
    }

}
