//
//  CarFormViewController.swift
//  Carangas
//
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import UIKit

class CarFormViewController: UIViewController {

    @IBOutlet weak var textFieldBrand: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPrice: UITextField!
    @IBOutlet weak var segmentedControlGasType: UISegmentedControl!
    @IBOutlet weak var buttonSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func save(_ sender: UIButton) {
    }
}
