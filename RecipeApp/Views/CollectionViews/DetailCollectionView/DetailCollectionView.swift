import UIKit

class DetailCollectionView: UICollectionViewController, FoodInformationDelegate {
    typealias DataSource = UICollectionViewDiffableDataSource<DetailCollectionViewSections, FoodDetailModel>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<DetailCollectionViewSections, FoodDetailModel>

    private var dataSource: DataSource?
    private var snapshot = DataSourceSnapshot()
    private var viewModel = RecipeViewModel()
    private var foodInformation: [FoodDetailModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getRecipeInformation(with: "pasta")
        
        setUpView()
    }

    private func setUpView() {
        collectionView.collectionViewLayout = Layouts.categoryLayout()
        collectionView.register(UINib(nibName: String(describing: DetailViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: DetailViewCell.self))
        collectionView.register(UINib(nibName: String(describing: HeaderCell.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: HeaderCell.self))
    }

    func didRetrieveFoodInformation(foodList: [FoodDetailModel]) {
        foodInformation = foodList
        configureDataSource()
        configureSnapshot()
        print(foodList[0].foodTitle)
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
}
