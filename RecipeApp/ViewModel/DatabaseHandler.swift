import Foundation
import UIKit
import CoreData

class DatabaseHandler {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var meals: [Meal] = []

    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }

    func loadMeals() {
        let request: NSFetchRequest<Meal> = Meal.fetchRequest()

        do {
            meals = try context.fetch(request)
        } catch {
            print("Error fetching tasks: \(error)")
        }
    }

    func addMeal(mealData: FoodDetailModel) {
        let newMeal = Meal(context: context)
        var steps: [String] = []
        var ingredients: [String] = []

        let foodIDInt = Int32(mealData.foodId)
        let mealMinutesInt = Int16(mealData.foodReadyInMinutes)
        let mealServingInt = Int16(mealData.foodServings)

        for step in mealData.foodSteps {
            steps.append(step.step ?? "")
            guard let ingredientData = step.ingredients else { return }
            for ingredient in ingredientData {
                ingredients.append(ingredient.name ?? "")
            }
        }

        newMeal.mealID = foodIDInt
        newMeal.mealTitle = mealData.foodTitle
        newMeal.mealReadyInMinutes = mealMinutesInt
        newMeal.mealServings = mealServingInt
        newMeal.mealImage = mealData.foodImage
        newMeal.mealSummary = mealData.foodSummary
        newMeal.isFavourited = mealData.isFavourite
        newMeal.mealIngredients = ingredients
        newMeal.mealInstructions = steps

        saveData()
        print("Saved Successfully")
    }

//    func generateData(with foodStepData: [Step], _ steps: [String], _ ingredients: [String]) {
//        for step in foodStepData {
//            steps.append(step.step)
//            steps.append(step.step)
//            guard let ingredientData = step.ingredients else { return }
//            for ingredient in ingredientData {
//                ingredients.append(ingredient.name ?? "")
//            }
//        }
//    }
}
