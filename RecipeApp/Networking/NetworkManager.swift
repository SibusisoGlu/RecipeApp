import Foundation

protocol FoodListRetreivable {
    func fetchFoodList(completion: @escaping ([Food]) -> Void)
}

class NetworkManager: FoodListRetreivable {
    func fetchFoodList(completion: @escaping ([Food]) -> Void) {
        
    }
}
