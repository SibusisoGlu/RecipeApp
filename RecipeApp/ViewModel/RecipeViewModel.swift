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

//    func getSearchResultData() {
//        print(foodInformation?[0].foodTitle)
//    }

}
