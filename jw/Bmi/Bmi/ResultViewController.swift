//
//  ResultViewController.swift
//  Bmi
//
//  Created by 제욱 on 5/26/25.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var LbResult: UILabel!
    var bmiValue: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        LbResult.text = "당신의 BMI는 \(bmiValue ?? "계산 오류")입니다"
    }
}

        // Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
