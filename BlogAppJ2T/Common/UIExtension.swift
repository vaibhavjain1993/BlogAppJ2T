//
//  UIExtension.swift
//  BlogAppJ2T
//
//  Created by Vaibhav jain on 11/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    static func register(for tableView: UITableView) {
        let bundle = Bundle(for: self)
        let cellName = String(describing: self)
        let cellIdentifier = reuseIdentifier
        let cellNib = UINib(nibName: cellName, bundle: bundle)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
    static func register(for tableViews: [UITableView]) {
        tableViews.forEach({
            register(for: $0)
        })
    }
}

//Convert time to string (time ago)
extension Date {

    func getElapsedInterval() -> String {

        let interval = Calendar.current.dateComponents([.year, .month, .day], from: self, to: Date())

        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        } else {
            return "a moment ago"

        }

    }
}

extension String{
    func calculateLabelHeight(font: UIFont, maxSize: CGSize) -> CGSize {
        let attrString = NSAttributedString.init(string: self, attributes: [NSAttributedString.Key.font:font])
        let rect = attrString.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        let size = CGSize.init(width: rect.size.width, height: rect.size.height)
        return size
    }
}
