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
    
    var car: Car!
    private let service = CarService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        if let car = car {
            title = "Edição"
            textFieldName.text = car.name
            textFieldBrand.text = car.brand
            textFieldPrice.text = "\(car.price)"
            segmentedControlGasType.selectedSegmentIndex = car.gasType
            buttonSave.setTitle("Alterar carro", for: .normal)
        }
    }
    
    @IBAction func save(_ sender: UIButton) {
        car = car ?? Car()
        
        car.name = textFieldName.text!
        car.brand = textFieldBrand.text!
        car.price = Int(textFieldPrice.text!) ?? 0
        car.gasType = segmentedControlGasType.selectedSegmentIndex
        
        if car._id != nil {
            service.updateCar(car: car) { [weak self] result in
                self?.showResult(result)
            }
        } else {
            service.createCar(car: car) { [weak self] result in
                self?.showResult(result)
            }
        }
    }
    
    private func showResult(_ result: Result<Void, CarServiceError>) {
        switch result {
        case .success:
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        case .failure(let serviceError):
            DispatchQueue.main.async { Alert.showError(serviceError.errorMessage, presenter: self) }
        }
    }
}
