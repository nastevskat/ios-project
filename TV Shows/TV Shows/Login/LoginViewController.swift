//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Infinum on 13/07/2022.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private var taps: Int = 0

  
  
    @IBOutlet weak var btnOutlet: UIButton!
    @IBOutlet weak var hello: UILabel!
    
    
    @IBAction func buttonPressed() {
        taps += 1
        hello.text = String(taps)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnOutlet.layer.cornerRadius = 35
       
    }
    

   

}
