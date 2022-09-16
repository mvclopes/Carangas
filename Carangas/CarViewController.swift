//
//  ViewController.swift
//  Carangas
//
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {
    
    @IBOutlet weak var labelBrand: UILabel!
    @IBOutlet weak var labelGasType: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    var car: Car?
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale =  Locale(identifier: "pt_BR")
        return numberFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let carFormViewController = segue.destination as? CarFormViewController
        carFormViewController?.car = car
    }
    
    private func setupUI() {
        if let car = car {
            title = car.name
            labelBrand.text = car.brand
            labelGasType.text = car.fuel
            labelPrice.text = numberFormatter.string(from: NSNumber(value: car.price))
        }
    }
}
