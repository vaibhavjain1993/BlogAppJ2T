//
//  CustomClass.swift
//  BlogAppJ2T
//
//  Created by Vaibhav jain on 11/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct Shortener {

    func string(from value: String) -> String? {
        guard let value = Int(value) else { return nil }

        if value < 1000 {
            return "\(value)"
        }
        if value < 100_000 {
            return string(from: value, divisor: 1000, suffix: "K")
        }
        if value < 100_000_000 {
            return string(from: value, divisor: 1_000_000, suffix: "M")
        }

        return string(from: value, divisor: 1_000_000_000, suffix: "B")
    }

    private func string(from value: Int, divisor: Double, suffix: String) -> String? {
        let formatter = NumberFormatter()
        let dividealue = Double(value) / divisor

        formatter.positiveSuffix = suffix
        formatter.negativeSuffix = suffix
        formatter.allowsFloats = true
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1

        return formatter.string(from: NSNumber(value: dividealue))
    }

}
