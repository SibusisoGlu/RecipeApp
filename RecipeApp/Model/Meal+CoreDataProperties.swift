//
//  Meal+CoreDataProperties.swift
//  RecipeApp
//
//  Created by Sibusiso Mbonani on 2022/12/21.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var mealID: Int32
    @NSManaged public var mealTitle: String?
    @NSManaged public var mealReadyInMinutes: Int16
    @NSManaged public var mealServings: Int16
    @NSManaged public var mealImage: String?
    @NSManaged public var mealSummary: String?
    @NSManaged public var isFavourited: Bool
    @NSManaged public var mealInstructions: [String]?
    @NSManaged public var mealIngredients: [String]?

}

extension Meal : Identifiable {

}
