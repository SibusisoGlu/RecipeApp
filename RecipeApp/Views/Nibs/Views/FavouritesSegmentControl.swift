import UIKit

class FavouritesSegmentControl: UIView {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    var steps: [String] = []
    var ingredients: [String] = []

    func prepareView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: SegmentControlCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SegmentControlCell.self))

        segmentControl.setTitle("Instructions", forSegmentAt: 0)
        segmentControl.setTitle("Ingredients", forSegmentAt: 1)
    }

    lazy var rowsToDisplay = steps

    @IBAction func segmentValuePressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            rowsToDisplay = steps
            tableView.reloadData()
        case 1:
            rowsToDisplay = ingredients
            tableView.reloadData()
        default:
            rowsToDisplay = []
            tableView.reloadData()
        }
        print(sender.selectedSegmentIndex)
    }

}

extension FavouritesSegmentControl: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowsToDisplay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SegmentControlCell.self), for: indexPath) as! SegmentControlCell

        if rowsToDisplay == steps {
            cell.title.text = rowsToDisplay[indexPath.row]
            return cell
        } else if rowsToDisplay == ingredients {
            cell.title.text = rowsToDisplay[indexPath.row]
            return cell
        } else {
            cell.title.text = ""
            return cell
        }
    }

}
