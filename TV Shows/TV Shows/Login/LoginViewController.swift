
import UIKit
extension UITextField{
    
    func setBottomBorder(){
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

class LoginViewController: UIViewController{
    

    @IBOutlet weak var LoginBtn: UIButton!
    
    @IBOutlet weak var emailOutlet: UITextField!
    
    @IBOutlet weak var PassOutlet: UITextField!
    
    @IBOutlet weak var Remember: UIButton!
    
    @IBOutlet weak var RegisterBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginBtn.layer.cornerRadius = 20

    
       
    }
    
    
}

