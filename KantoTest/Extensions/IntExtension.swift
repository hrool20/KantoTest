//
//  IntExtension.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/28/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation


// MARK: Source from: https://gist.github.com/gbitaudeau/daa4d6dc46517b450965e9c7e13706a3
extension Int {
    func useAbbreviation() -> String {
        typealias Abbrevation = (threshold: Float, divisor: Float, suffix: String)
        
        let numberFormatter = NumberFormatter()
        let abbreviations: [Abbrevation] = [
            (0, 1, ""),
            (100.0, 1000.0, "K"),
            (100_000.0, 1_000_000.0, "M"),
            (100_000_000.0, 1_000_000_000.0, "B")
        ]
        
        let startValue = Float(abs(self))
        let abbreviation: Abbrevation = {
            var prevAbbreviation = abbreviations[0]
            for tmpAbbreviation in abbreviations {
                if (startValue <= tmpAbbreviation.threshold) {
                    break
                }
                prevAbbreviation = tmpAbbreviation
            }
            return prevAbbreviation
        }()
        let value = Float(self) / abbreviation.divisor
        numberFormatter.positiveSuffix = abbreviation.suffix
        numberFormatter.negativeSuffix = abbreviation.suffix
        numberFormatter.allowsFloats = true
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: value)) ?? "\(self)"
    }
}
