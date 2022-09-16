//
//  CarsTableViewController.swift
//  Carangas
//
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {

    // MARK: - Properties
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Sem carros cadastrados"
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 16.0)
        return label
    }()
    
    private var cars: [Car] = []
    private var service = CarService()
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCars()
    }
        
    private func loadCars() {
        service.loadCars { result in
            switch result {
            case .success(let cars):
                self.cars = cars
                self.reloadCars()
            case .failure(let carServiceError):
                print(carServiceError.errorMessage)
            }
        }
    }
    
    private func reloadCars() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = cars.count
		tableView.backgroundView = count == 0 ? label : nil
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let car = cars[indexPath.row]
        cell.textLabel?.text = car.name
        cell.detailTextLabel?.text = car.brand
        return cell
    }
}
