import UIKit

class FavoutiesViewController: UIViewController, NibLoadable {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    private let databaseHandler = DatabaseHandler()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        databaseHandler.loadMeals()
        setUpTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        databaseHandler.loadMeals()
        tableView.reloadData()
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
            cell.setUpCell(image: data.mealImage ?? "", title: data.mealTitle ?? "", firstSubtitle: "\(data.mealReadyInMinutes) mins", secondSubtitle: "\(data.mealServings) servings")
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
        viewController.itemIndex = indexPath
        viewController.prepareView(with: data)
        show(viewController, sender: self)
    }
}

extension FavoutiesViewController {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .normal, title: "Remove") { action, view, completion in
            let removeMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this Meal?", preferredStyle: .alert)

            let yes = UIAlertAction(title: "Yes", style: .default) { action in
                self.databaseHandler.meals[indexPath.row].isFavourited = !self.databaseHandler.meals[indexPath.row].isFavourited
                self.context.delete(self.databaseHandler.meals[indexPath.row])
                self.databaseHandler.meals.remove(at: indexPath.row)

                self.databaseHandler.saveData()
                self.tableView.reloadData()
                self.databaseHandler.loadMeals()
            }

            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
                return
            }

            removeMessage.addAction(yes)
            removeMessage.addAction(cancel)

            self.present(removeMessage, animated: true, completion: nil)
        }

        return UISwipeActionsConfiguration(actions: [removeAction])
    }
}
