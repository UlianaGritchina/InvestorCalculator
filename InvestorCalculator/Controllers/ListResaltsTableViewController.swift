//
//  ListResaltsTableViewController.swift
//  InvestorCalculator
//
//  Created by Ульяна Гритчина on 15.01.2022.
//

import UIKit

class ListResaltsTableViewController: UITableViewController {
    
    var resaltModel: Resalts!
    private var mtitle = "Месяцы"
    
    override func viewDidLoad() {
        if resaltModel.period == 1 {
            mtitle = "Годы"
        }
        navigationItem.title = mtitle
    }
    // MARK: - Table view data source
    
    private func formated(number: Float) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        resaltModel.resalts.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resaltCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = String(formated(number: resaltModel.resalts[indexPath.section]))
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(section + 1)
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return "+ \(formated(number: resaltModel.resalts[0] - resaltModel.start))"
            
        default:
            return " + \(formated(number: resaltModel.resalts[section] - resaltModel.resalts[section - 1]))"
        }
    }
}
