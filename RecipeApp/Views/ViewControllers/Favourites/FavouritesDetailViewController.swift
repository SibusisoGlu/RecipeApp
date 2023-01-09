import UIKit

class FavouritesDetailViewController: UIViewController, NibLoadable, Favouritable {
    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var bottomContainer: UIView!

    var data: Meal?
    var itemIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        addTopContainerView()
        addBottomContainerView()
    }

    func prepareView(with databaseData: Meal) {
        data = databaseData
    }

    private static func createTopView(with mealInformation: Meal, and index: Int) -> FavouritesDetailView? {
        let bundle = Bundle.main
        guard let view = bundle.loadNibNamed("FavouritesDetailView", owner: self)?.first as? FavouritesDetailView else {
            return nil
        }

        view.foodData = mealInformation
        view.favouriteDelegate = self as? Favouritable
        view.index = index
        view.setUpView()
        view.setUpSummary(isHomeView: false)
        return view
    }

    func toggleFavourite(for view: UIView) {
        data?.isFavourited.toggle()
    }

    private func addTopContainerView() {
        if let view = FavouritesDetailViewController.createTopView(with: data ?? Meal(), and: itemIndex) {
            self.topContainer.addSubview(view)
            view.pinEdges(to: self.topContainer)
        }
    }

    private static func create(with instructions: [String], and ingredients: [String]) -> FavouritesSegmentControl? {
        let bundle = Bundle.main
        guard let segmentControlView = bundle.loadNibNamed("FavouritesSegmentControl", owner: self)?.first as? FavouritesSegmentControl else {
            return nil
        }

        segmentControlView.steps = instructions
        segmentControlView.ingredients = ingredients
        segmentControlView.prepareView()
        return segmentControlView
    }

    private func addBottomContainerView() {
        if let segmentControlView = FavouritesDetailViewController.create(with: data?.mealInstructions ?? [], and: data?.mealIngredients ?? []) {
            self.bottomContainer.addSubview(segmentControlView)
            segmentControlView.pinEdges(to: self.bottomContainer)
        }
    }


}
