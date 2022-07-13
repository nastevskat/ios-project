//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Infinum on 13/07/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    var taps: Int = 0

    @IBOutlet weak var btnOutlet: UIButton!
    @IBOutlet weak var hello: UILabel!
    
    @IBAction func btn(_ sender: Any) {
        taps += 1
        hello.text = String(taps)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnOutlet.layer.cornerRadius = 35
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
