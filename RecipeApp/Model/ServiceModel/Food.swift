import Foundation

// MARK: - Food
struct Food: Codable {
    let results: [Result]?
    let offset, number, totalResults: Int?
}

// MARK: - Result
struct Result: Codable {
    let id: Int?
    let title: String?
    let readyInMinutes, servings: Int?
    let image: String?
    let summary: String?
    let dishTypes, diets: [String]?
    let analyzedInstructions: [AnalyzedInstruction]?
    let license: String?

    enum CodingKeys: String, CodingKey {
        case  id, title, readyInMinutes, servings
        case image, summary, dishTypes, diets, analyzedInstructions
        case license
    }
}

// MARK: - AnalyzedInstruction
struct AnalyzedInstruction: Codable {
    let name: String?
    let steps: [Step]?
}

// MARK: - Step
struct Step: Codable {
    let number: Int?
    let step: String?
    let ingredients, equipment: [Ent]?
    let length: Length?
}

// MARK: - Ent
struct Ent: Codable {
    let id: Int?
    let name, localizedName, image: String?
    let temperature: Length?
}

// MARK: - Length
struct Length: Codable {
    let number: Int?
    let unit: Unit?
}

enum Unit: String, Codable {
    case fahrenheit = "Fahrenheit"
    case minutes = "minutes"
}
