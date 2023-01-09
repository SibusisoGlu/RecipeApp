import UIKit

class DetailCollectionView: UICollectionViewController, FoodInformationDelegate {
    typealias DataSource = UICollectionViewDiffableDataSource<DetailCollectionViewSections, FoodDetailModel>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<DetailCollectionViewSections, FoodDetailModel>

    private var dataSource: DataSource?
    private var snapshot = DataSourceSnapshot()
    private var viewModel = RecipeViewModel()
    private var foodInformation: [FoodDetailModel] = []

    let meals = ["pasta", "chicken", "steak", "cheese", "potato", "prawns", "soup", "stir-fry", "rice"]

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionView.dataSource = dataSource
        setUpView()
    }

    private func setUpView() {
        collectionView.collectionViewLayout = Layouts.categoryLayout()
        collectionView.register(UINib(nibName: String(describing: DetailViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: DetailViewCell.self))
        collectionView.register(UINib(nibName: String(describing: HeaderCell.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: HeaderCell.self))

        let randomMeal = getRandomMeal()
        viewModel.getRecipeInformation(with: randomMeal)
    }

    func getRandomMeal() -> String {
        let count = meals.count - 1
        let randomInt = Int.random(in: 0...count)
        print(count)
        return meals[randomInt]
    }

    func didRetrieveFoodInformation(foodList: [FoodDetailModel]) {
        foodInformation = foodList
        configureDataSource()
        configureSnapshot()
    }

    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailViewCell.self), for: indexPath) as? DetailViewCell
            cell?.setUpView(image: item.foodImage, foodTitle: item.foodTitle, foodSubtitle: item.foodReadyInMinutes)
            return cell

        }

        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return UICollectionReusableView()
            }

            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as? HeaderCell

            let section = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section]
            view?.headerText.text = section?.rawValue
            return view
        }
    }

    private func configureSnapshot(animatingChange: Bool = false) {
        let sections = DetailCollectionViewSections.allCases

        snapshot = DataSourceSnapshot()
        snapshot.appendSections([.recomendations])

        for section in sections {
            snapshot.appendItems(foodInformation, toSection: section)
        }
        dataSource?.apply(snapshot)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        let selectedFood = foodInformation[indexPath.row]
        viewController.prepareView(with: selectedFood)
        show(viewController, sender: self)
    }
}
