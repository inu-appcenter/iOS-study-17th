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
        let bmiString = String(format: "%.2f", bmi)

        let vc = storyboard?.instantiateViewController(withIdentifier: "ResultView") as! ResultView
        vc.bmiValue = bmiString
        navigationController?.pushViewController(vc, animated: true)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

