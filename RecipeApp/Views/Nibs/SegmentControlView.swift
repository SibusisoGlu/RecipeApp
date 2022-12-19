import UIKit

class SegmentControlView: UIView {
    typealias dataSourceSnapshot = NSDiffableDataSourceSnapshot

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    var foodStepData: [Step] = []

    func showData() {
        for data in foodStepData {
            print(data.step)
        }
    }

}
