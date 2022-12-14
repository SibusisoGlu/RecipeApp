import Foundation

protocol FoodListRetreivable {
    func fetchFoodDetails(for query: String, completion: @escaping ([FoodDetailModel]?) -> Void)
}

protocol FoodInformationDelegate {
    func didRetrieveFoodInformation(foodList: [FoodDetailModel])
}

class NetworkManager: FoodListRetreivable {
    private let baseURL = "https://api.spoonacular.com/recipes/complexSearch?addRecipeInformation=true"
    private let APIKey = "b9c19eab49404c3fab81382adb8d38d7"
//    var cache = [String: [FoodDetailModel]] = [:]
    var foodModel: [FoodDetailModel] = []
    var delegate: FoodInformationDelegate?

    func fetchFoodDetails(for query: String, completion: @escaping ([FoodDetailModel]?) -> Void) {
        let completeURL = "\(baseURL)&apiKey=\(APIKey)&query=\(query)"
        guard let url = URL(string: completeURL) else {
            completion([])
            return
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let safeData = data {
                let foodInformation = try? JSONDecoder().decode(Food.self, from: safeData)
                self?.foodModel = self?.convertFoodModel(foodData: foodInformation) ?? []
                self?.delegate?.didRetrieveFoodInformation(foodList: self?.foodModel ?? [])
                completion(self?.foodModel)
            } else {
                completion([])
            }
        }
        task.resume()
    }

    private func convertFoodModel(foodData: Food?) -> [FoodDetailModel]? {
        guard let foodInformation = foodData?.results else { return nil }
        var foodResults: [FoodDetailModel] = []
        for foodItem in foodInformation {
            let food = FoodDetailModel(id: foodItem.id ?? 0,
                                 title: foodItem.title ?? "",
                                 readyInMinutes: foodItem.readyInMinutes ?? 0,
                                 servings: foodItem.servings ?? 0,
                                 image: foodItem.image ?? "",
                                 summary: foodItem.summary ?? "",
                                 steps: foodItem.analyzedInstructions?[0].steps ?? [])

            foodResults.append(food)
        }
        return foodResults
    }
}
