//
//  ViewController.swift
//  InvestorCalculator
//
//  Created by Ульяна Гритчина on 12.01.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func getTermTapy(value: Int)
}

class MainViewController: UIViewController {
    
    @IBAction func unwind(segue: UIStoryboardSegue) {}
    
    @IBOutlet weak var initialPaymentTF: UITextField!
    @IBOutlet weak var termTF: UITextField!
    @IBOutlet weak var additionalInvestmentsTF: UITextField!
    @IBOutlet weak var percentTF: UITextField!
    
    @IBOutlet weak var startButton: UIButton!
    
    private var start: Float!
    private var per: Int!
    private var procents: Float!
    private var dop: Float!
    private var sum: Float!
    private var resalt: Float = 0
    private var resalts: [Float] = []
    private var resaltModel = Resalts(mainResalt: 0, resalts: [0], sum: 0)
    private var termTapy = 0
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 10
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let settigsVC = segue.destination as? SettingsViewController {
            
            settigsVC.delegate = self
            settigsVC.termTapy = termTapy
            
        } else if let navigationVC = segue.destination as? UINavigationController {
            
            let resaltsVC = navigationVC.topViewController as? ResaltsViewController
            resaltsVC?.resaltModel = resaltModel
        }
    }
    
    @IBAction func startButtonPressed() {
        startButton.layer.cornerRadius = 10
        start = Float(initialPaymentTF.text ?? "0")
        per = Int(termTF.text ?? "0")
        procents = Float(percentTF.text ?? "0")
        dop = Float(additionalInvestmentsTF.text ?? "0")
        sum = 0
        
        resalt = start
        
        resalt = resalt + (resalt * procents / termTapy == 0 ? procents / 12 : procents / 100)
        resalts.append(resalt)

        for _ in 1..<per {
            sum += dop
            resalt = resalt + dop + (((resalt + dop) * termTapy == 0 ? procents / 12 : procents) / 100)
            resalts.append(resalt)
        }
        resaltModel = Resalts(mainResalt: resalts.last ?? 0, resalts: resalts, sum: sum)
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func getTermTapy(value: Int) {
        switch value {
        case 0:
            termTF.placeholder = "0 месяцев"
            termTapy = 0
        case 1:
            termTF.placeholder = "0 лет"
            termTapy = 1
        default :
            break
        }
    }
}

extension MainViewController {
    
}
