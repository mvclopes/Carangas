//
//  Car.swift
//  Carangas
//
//  Created by Matheus Lopes on 15/09/22.
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import Foundation

class Car: Codable {
    var _id: String?
    var brand: String = ""
    var gasType: Int = 0
    var name: String = ""
    var price: Int = 0
    
    var fuel: String {
        switch gasType {
        case 0:
            return "Flex"
        case 1:
            return "Etanol"
        default:
            return "Gasolina"
        }
    }
}
