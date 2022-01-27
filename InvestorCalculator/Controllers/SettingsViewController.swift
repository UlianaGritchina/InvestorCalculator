//
//  SettingsViewController.swift
//  InvestorCalculator
//
//  Created by Ульяна Гритчина on 12.01.2022.
//

import UIKit

class SettingsViewController:
                                    
    UIViewController {
    
    @IBOutlet weak var termSC: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    
    var delegate: SettingsViewControllerDelegate!
    var termTapy: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = 10
        termSC.selectedSegmentIndex = termTapy
    }

    @IBAction func saveButtonPressed() {
        delegate.getTermTapy(value: termSC.selectedSegmentIndex)
    }
}
