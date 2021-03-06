//
//  Resalts.swift
//  InvestorCalculator
//
//  Created by Ульяна Гритчина on 13.01.2022.
//

import Foundation


struct Resalts {
    var period: Int
    var start: Float
    var mainResalt: Float
    var resalts: [Float]
    var sum: Float
    var proc: Float {
        mainResalt - sum - start
    }
}
