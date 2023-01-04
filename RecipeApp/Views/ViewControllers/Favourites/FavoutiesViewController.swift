import UIKit

class FavoutiesViewController: UIViewController, NibLoadable {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    private let databaseHandler = DatabaseHandler()
    private var data: [Meal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        databaseHandler.loadMeals()
        setUpTableView()
    }

    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: FoodTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FoodTableViewCell.self))
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        print(searchField.text)
        print(databaseHandler.meals[0].mealInstructions)
        print(databaseHandler.meals[0].mealIngredients)

    }
}

extension FavoutiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return databaseHandler.meals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = databaseHandler.meals[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodTableViewCell.self), for: indexPath) as? FoodTableViewCell {
            cell.setUpCell(image: data.mealImage ?? "", title: data.mealTitle ?? "", firstSubtitle: String(data.mealReadyInMinutes), secondSubtitle: String(data.mealServings))
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailView(with: indexPath.row)
    }

    private func navigateToDetailView(with indexPath: Int) {
        let data = databaseHandler.meals[indexPath]
        let viewController = FavouritesDetailViewController()
        viewController.prepareView(with: data)
        show(viewController, sender: self)
    }
}
