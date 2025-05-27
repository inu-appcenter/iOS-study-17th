//
//  ViewController.swift
//  Bmiuikit
//
//  Created by 제욱 on 5/4/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cmTextField: UITextField!
    @IBOutlet weak var kgTextField: UITextField!

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var calculateResult: UIButton!
    
    @IBAction func calculateBmi(_ sender: UIButton) {
        guard let cmText = cmTextField.text,
              let kgText = kgTextField.text,
              let cm = Double(cmText),
              let kg = Double(kgText) else {
            return
        }

        let bmi = kg / pow(cm / 100, 2)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let resultVC = storyboard.instantiateViewController(identifier: "ResultView") as? ResultView {
            resultVC.bmiValue = bmi
            present(resultVC, animated: true, completion: nil)
              }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


}

