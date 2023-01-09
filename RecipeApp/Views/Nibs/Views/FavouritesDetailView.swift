import UIKit

class FavouritesDetailView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!

    @IBOutlet weak var detailLabel: UILabel!

    private let databaseHandler = DatabaseHandler()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favouriteDelegate: Favouritable?
    var foodData: Meal?
    var index: Int = 0

    func setUpView() {
        guard let data = foodData else { return }

        imageView.loadImage(fromURL: data.mealImage ?? "")
        titleLable.text = data.mealTitle
        titleLable.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        ImageString.imageStringConfigurator(with: subTitleLabel, and: String(data.mealReadyInMinutes))

        checkFavourite(isFavourite: data.isFavourited)
    }

    func setUpSummary(isHomeView: Bool) {
        if isHomeView {
            detailLabel.text = foodData?.mealSummary ?? ""
            if detailLabel.text!.count > 1 {
               let readmoreFont = UIFont(name: "Helvetica-Oblique", size: 15.0)
                let readmoreFontColor = UIColor.blue
                DispatchQueue.main.async {
                    self.detailLabel.addTrailing(with: "... ", moreText: "Readmore", moreTextFont: readmoreFont!, moreTextColor: readmoreFontColor)
                }
            }
        } else {
            detailLabel.isHidden = true
        }
    }

    @IBAction func favouriteButtonPressed(_ sender: UIButton) {
        favouriteDelegate?.toggleFavourite(for: self)

        guard let data = foodData else { return }

        data.isFavourited.toggle()
        setUpView()

        if data.isFavourited {

        } else {
            databaseHandler.loadMeals()
            self.context.delete(self.databaseHandler.meals[index])
            databaseHandler.saveData()
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
