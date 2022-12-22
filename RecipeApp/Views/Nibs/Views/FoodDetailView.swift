import UIKit

protocol Favouritable {
    func toggleFavourite(for view: UIView)
}

class FoodDetailView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var foodTime: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!

    var favouriteDelegate: Favouritable?
    var foodData: FoodDetailModel?
    private let databaseHandler = DatabaseHandler()
    var isFavourited: Bool = false

    func setUpView() {
        guard let data = foodData else { return }

        imageView.loadImage(fromURL: data.foodImage)
        foodTitle.text = data.foodTitle
        foodTime.text = "\(data.foodReadyInMinutes) mins"

        checkFavourite(isFavourite: data.isFavourite)
        databaseHandler.loadMeals()
    }

    @IBAction func favouriteButtonPressed(_ sender: UIButton) {
        favouriteDelegate?.toggleFavourite(for: self)

        guard let data = foodData else { return }

        data.isFavourite.toggle()
        setUpView()
        
        if data.isFavourite {
            databaseHandler.addMeal(mealData: data)
        } else {
//             search through database to see if exists then remove
        }
    }

    func checkFavourite(isFavourite: Bool) {
        if isFavourite {
            favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
