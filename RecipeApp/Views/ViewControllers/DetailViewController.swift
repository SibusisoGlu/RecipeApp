import UIKit

class DetailViewController: UIViewController, NibLoadable {
    @IBOutlet weak private var topContainer: UIView!
    @IBOutlet weak private var bottomContainer: UIView!

    private var foodData: FoodDetailModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        addTopContainerView()
        addBottomContainerView()
    }

    func prepareView(with foodInformation: FoodDetailModel) {
        foodData = foodInformation
    }

    private static func createTopView(with data: FoodDetailModel) -> FoodDetailView? {
        let bundle = Bundle.main
        guard let foodDetailView = bundle.loadNibNamed("FoodDetailView", owner: self)?.first as? FoodDetailView else {
            return nil
        }

        foodDetailView.setUpView(with: data.foodImage, data.foodTitle, data.foodReadyInMinutes, isFavourite: false)
        return foodDetailView
    }

    private func addTopContainerView() {
        guard let data = foodData else { return }
        if let foodDetailView = DetailViewController.createTopView(with: data) {
            self.topContainer.addSubview(foodDetailView)
            foodDetailView.pinEdges(to: self.topContainer)
        }
    }

    private static func create(with data: [Step]) -> SegmentControlView? {
        let bundle = Bundle.main
        guard let segmentControlView = bundle.loadNibNamed("SegmentControlView", owner: self)?.first as? SegmentControlView else {
            return nil
        }

        segmentControlView.foodStepData = data
        segmentControlView.prepareView()
        segmentControlView.generateData()
        return segmentControlView
    }

    private func addBottomContainerView() {
        if let segmentControlView = DetailViewController.create(with: foodData?.foodSteps ?? []) {
            self.bottomContainer.addSubview(segmentControlView)
            segmentControlView.pinEdges(to: self.bottomContainer)
        }
    }

}
