import UIKit

class FavouritesDetailViewController: UIViewController, NibLoadable {
    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var bottomContainer: UIView!

    var data: Meal?

    override func viewDidLoad() {
        super.viewDidLoad()
        addBottomContainerView()
    }

    func prepareView(with databaseData: Meal) {
        data = databaseData
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
