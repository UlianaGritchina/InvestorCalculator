//
//  ResaltsViewController.swift
//  InvestorCalculator
//
//  Created by Ульяна Гритчина on 12.01.2022.
//

import UIKit

class ResaltsViewController: UIViewController {

    @IBOutlet weak var readyButton: UIButton!
    
    @IBOutlet weak var resaltLable: UILabel!
    @IBOutlet weak var sumLable: UILabel!
    @IBOutlet weak var procentsLable: UILabel!
    
    var resalt: String!
    var resaltModel: Resalts!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readyButton.layer.cornerRadius = 10
        resaltLable.text = formated(number: resaltModel.mainResalt)
        sumLable.text = formated(number: resaltModel.sum)
        procentsLable.text = formated(number: resaltModel.proc)
    }
    
    @IBAction func radyButtonPressed() {
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let listVC = segue.destination as? ListResaltsTableViewController else { return }
        listVC.resaltModel = resaltModel
    }
}

extension ResaltsViewController {
    private func formated(number: Float) -> String {
        
        let newNumber = Float(number)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        
        
        return formatter.string(from: NSNumber(value: newNumber)) ?? ""
    }
}
