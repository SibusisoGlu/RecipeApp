//
//  SegmentControlCell.swift
//  RecipeApp
//
//  Created by Sibusiso Mbonani on 2022/12/19.
//

import UIKit

class SegmentControlCell: UITableViewCell {
    @IBOutlet weak var segmentCellView: UIView!
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
