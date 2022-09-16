//
//  Alert.swift
//  Carangas
//
//  Created by Matheus Lopes on 15/09/22.
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    static func showError(_ error: String, presenter: UIViewController) {
        let alert = UIAlertController(title: "Erro", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        presenter.present(alert, animated: true)
    }
}
