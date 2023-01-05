import UIKit

class HomeViewController: UIViewController, NibLoadable {
    @IBOutlet weak var personalMealView: UIView!
    @IBOutlet weak var recommendedMealsView: UIView!

    private let databaseHandler = DatabaseHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        databaseHandler.loadMeals()
        addTopView()
        setUpBottomContainer()
        setUpNavigationItem()
    }

    private func setUpNavigationItem() {
        let favouritesButton = UIBarButtonItem(title: "Favs",
                                               style: .plain,
                                               target: self,
                                               action: #selector(goToFavourites))

        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                               style: .plain,
                                               target: self,
                                               action: #selector(goToSearch))
        navigationItem.rightBarButtonItems = [favouritesButton, searchButton]
    }

    @objc func goToFavourites() {
        let favoutitesViewController = FavoutiesViewController()
        navigationController?.pushViewController(favoutitesViewController, animated: true)
    }

    @objc func goToSearch() {
        let searchViewController = SearchViewController()
        navigationController?.pushViewController(searchViewController, animated: true)
    }

    private static func createBottomView(with data: Meal) -> FavouritesDetailView? {
        let bundle = Bundle.main
        guard let view = bundle.loadNibNamed("FavouritesDetailView", owner: self)?.first as? FavouritesDetailView else {
            return nil
        }

        view.foodData = data
        view.favouriteButton.isHidden = true
        view.setUpView()
        return view
    }

    private func addTopView() {
        let count = databaseHandler.meals.count
        let randomInt = Int.random(in: 1...count)

        if let view = HomeViewController.createBottomView(with: databaseHandler.meals[randomInt - 1]) {
            self.personalMealView.addSubview(view)
            view.pinEdges(to: personalMealView)
        }
    }

    private func setUpBottomContainer() {
        let controller = DetailCollectionView(collectionViewLayout: UICollectionViewLayout())

        addChild(controller)

        controller.collectionView.translatesAutoresizingMaskIntoConstraints = false
        recommendedMealsView.addSubview(controller.collectionView)

        NSLayoutConstraint.activate([
            controller.collectionView.leftAnchor.constraint(equalTo: recommendedMealsView.leftAnchor),
            controller.collectionView.topAnchor.constraint(equalTo: recommendedMealsView.topAnchor),
            controller.collectionView.rightAnchor.constraint(equalTo: recommendedMealsView.rightAnchor),
            controller.collectionView.bottomAnchor.constraint(equalTo: recommendedMealsView.bottomAnchor)])

        controller.didMove(toParent: self)
    }

}
