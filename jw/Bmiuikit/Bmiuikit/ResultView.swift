//
//  ResultView.swift
//  Bmiuikit
//
//  Created by 제욱 on 5/5/25.
//

import UIKit

class ResultView: UIViewController {
    
    
    @IBOutlet weak var resultPrint: UILabel!
    @IBOutlet weak var goBack: UIButton!
    @IBOutlet weak var doDietLabel: UILabel!
    @IBOutlet weak var bmiResultLabel: UILabel!
    
    resultPrint.text = bmiValue
    
    var bmiValue: String?
    //bmiLabel.text = String(format: "%.2f", bmiValue)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
 
