
import UIKit
import MBProgressHUD
import Alamofire

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.white.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}


final class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var LoginBtn: UIButton!
    @IBOutlet private weak var emailOutlet: UITextField!
    @IBOutlet private weak var PassOutlet: UITextField!
    @IBOutlet private weak var Remember: UIButton!
    @IBOutlet private weak var RegisterBtn: UIButton!
    
    var isChecked = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailOutlet.addBottomBorder()
        self.PassOutlet.addBottomBorder()
        LoginBtn.layer.cornerRadius = 20
        emailOutlet.delegate = self
        LoginBtn.isUserInteractionEnabled = false
        LoginBtn.alpha = 0.5
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty{
            LoginBtn?.isUserInteractionEnabled = true
            LoginBtn?.alpha = 1.0
        } else {
            LoginBtn?.isUserInteractionEnabled = false
            LoginBtn?.alpha = 0.5
        }
        return true
    }
    
    
    @IBAction func onRegister() {
        registerUserWith(email: "tamaran@infinum.com", password: "infinum1")
        registerUserWith(email: emailOutlet.text!, password: PassOutlet.text!)
        performSegue(withIdentifier: "toHomeVC", sender: nil)
        
    }
    
    @IBAction func onLogin() {
        
        loginUserWith(email: emailOutlet.text!, password: PassOutlet.text!)
        performSegue(withIdentifier: "toHomeVC", sender: nil)
    }
    
    
    @IBAction func onRememberBtn() {
        if isChecked {
            isChecked = false
            Remember.setImage(UIImage(named: "ic-checkbox-selected"), for: .normal)
        }else{
            isChecked = true
            Remember.setImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
        }
    }
    
    
}

private extension LoginViewController {
    
    func registerUserWith(email: String, password: String) {
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
        let parameters: [String: String] = [
            "email": email,
            "password": password,
            "password_confirmation": password
        ]
        
        AF
            .request(
                "https://tv-shows.infinum.academy/users",
                method: .post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UserResponse.self) { [weak self] dataResponse in
                guard let self = self else { return }
                MBProgressHUD.hide(for: self.view, animated: true)
                switch dataResponse.result {
                case .success(let response):
                    print("Success: \(response)")
                    let headers = dataResponse.response?.headers.dictionary ?? [:]
                    self.handleSuccesfulLogin(for: response.user, headers: headers)
                case .failure(let error):
                    let alertController = UIAlertController(title: "Registration Failed", message: "Something happened try again", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default)
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true)
                    print("Failure: \(error)")
                }
            }
    }
}

private extension LoginViewController {
    
    func loginUserWith(email: String, password: String) {
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        AF
            .request(
                "https://tv-shows.infinum.academy/users/sign_in",
                method: .post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UserResponse.self) { [weak self] dataResponse in
                guard let self = self else { return }
                MBProgressHUD.hide(for: self.view, animated: true)
                switch dataResponse.result {
                case .success(let response):
                    print("Success: \(response)")
                case .failure(let error):
                    let alertController = UIAlertController(title: "Login Failed", message: "Something happened try again", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default)
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true)
                    print("Failure: \(error)")
                }
            }
    }
    
    func handleSuccesfulLogin(for user: User, headers: [String: String]) {
        
        guard let authInfo = try? AuthInfo(headers: headers) else {
            return
        }
    }
}




