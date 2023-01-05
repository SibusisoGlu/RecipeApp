import Foundation
import UIKit

class ImageString {
    static func imageStringConfigurator(with label: UILabel, and data: String) -> UILabel {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "clock")

        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: " \(data) mins")
        imageString.append(textString)

        label.attributedText = imageString
        label.sizeToFit()
        return label
    }
}
