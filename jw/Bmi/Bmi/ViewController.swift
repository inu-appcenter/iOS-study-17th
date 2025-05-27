//
//  ViewController.swift
//  Bmi
//
//  Created by 제욱 on 5/25/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var LbName: UILabel!
    
    @IBOutlet weak var LbHeight: UILabel!
    @IBOutlet weak var TfHeight: UITextField!
    
    @IBOutlet weak var LbWeight: UILabel!
    @IBOutlet weak var TfWeight: UITextField!
    
    

    @IBOutlet weak var BtResult: UIButton!
    @IBAction func BtResultAction(_ sender: UIButton) {
        guard let bmi = calculateBmi() else {
            print("입력값 오류")
            return
        }
        performSegue(withIdentifier: "showResult", sender: bmi)
    }
    
    func calculateBmi() -> String? { //BMI 계산 함수, ? 옵셔널 nilvhgka
        guard let cmHeight = TfHeight.text,
              let kgweight = TfWeight.text,
              let cm = Double(cmHeight),
              let kg = Double(kgweight)
        else {
            return nil
        }
        let m = cm / 100
        let bmi = kg / (m * m)
        return String(format: "%.2f", bmi)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult",
           let resultVC = segue.destination as? ResultViewController,
           let bmi = sender as? String {
            resultVC.bmiValue = bmi
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    }
