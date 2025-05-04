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
    
    var bmiValue: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        resultPrint.text = bmiValue
        // Do any additional setup after loading the view.
    }


}
 
