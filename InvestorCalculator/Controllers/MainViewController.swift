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
    private var resaltModel = Resalts(period: 0, start: 0, mainResalt: 0, resalts: [0], sum: 0)
    private var termTapy = 0
    private var dopTapy = 0
    
    private var currentTextField = UITextField()
    private var toolBarText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 10
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if let settigsVC = segue.destination as? SettingsViewController {
            
            settigsVC.delegate = self
            settigsVC.termTapy = termTapy
            
        } else if let navigationVC = segue.destination as? UINavigationController {
            if initialPaymentTF.text == "" || termTF.text == "" || additionalInvestmentsTF.text == "" || percentTF.text == "" {
                showAlert(title: "Ошибка", masahe: "Заполните все поля")
            } else {
                getResalts()
                let resaltsVC = navigationVC.topViewController as? ResaltsViewController
                resaltsVC?.resaltModel = resaltModel
            }
        }
    }
}

extension MainViewController: SettingsViewControllerDelegate, UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        currentTextField = textField
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        textField.inputAccessoryView = keyboardToolBar
        switch currentTextField {
            
        case initialPaymentTF:
            toolBarText = "Начальный взнос"
            
        case additionalInvestmentsTF:
            toolBarText = "Доп. вложения"
            
        case termTF:
            toolBarText = "Срок"
            
        default:
            toolBarText = "Проценты"
        }
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(startb)
        )
        
        let text = UIBarButtonItem(title: toolBarText, image: nil, primaryAction: nil, menu: nil)
        text.tintColor = .systemGray
        
        let nextButton = UIBarButtonItem(
            image:  UIImage(systemName: "arrowshape.turn.up.right.circle"),
            style: .done,
            target: self,
            action: #selector(nextTF)
            
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolBar.items = [text, flexBarButton, nextButton, doneButton]
    }
    
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

extension MainViewController{

    private func showAlert(title: String, masahe: String) {
        let alert = UIAlertController(title: title, message: masahe, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func getResalts() {
        resalts = []
        startButton.layer.cornerRadius = 10
        start = Float(initialPaymentTF.text ?? "0")
        per = Int(termTF.text ?? "0")
        procents = Float(percentTF.text ?? "0")
        dop = Float(additionalInvestmentsTF.text ?? "0")
        sum = 0
        
        resalt = start
        
        if termTapy == 0 {
            procents = procents / 12
            resalt = resalt + (resalt * procents / 100)
            resalts.append(resalt)
        } else {
            dop *= 11
            resalt = resalt + (resalt * procents / 100) + dop
            resalts.append(resalt)
            sum = dop
        }
            for _ in 1..<per {
                sum += dop
                resalt = resalt + dop + (((resalt + dop) *  procents / 100))
                resalts.append(resalt)
            }
        
        resaltModel = Resalts(period: termTapy, start: start, mainResalt: resalts.last ?? 0, resalts: resalts, sum: sum)
        
        view.endEditing(true)
    }
    
    @objc private func startb() {
        view.endEditing(true)
    }
    
    @objc private func nextTF() {
        view.endEditing(true)
        switch currentTextField {
            
        case initialPaymentTF:
            termTF.becomeFirstResponder()
            
            
        case additionalInvestmentsTF:
            percentTF.becomeFirstResponder()
            
            
        case termTF:
            additionalInvestmentsTF.becomeFirstResponder()
            
        default:
            view.endEditing(true)
        }
    }
}





