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
        resaltLable.text = String(resaltModel.mainResalt)
        sumLable.text = String(resaltModel.sum)
        procentsLable.text = String(resaltModel.proc)
    }
    
    @IBAction func radyButtonPressed() {
        dismiss(animated: true)
    }
}
