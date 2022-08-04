
import UIKit
import MBProgressHUD
import Alamofire


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
    
    @IBAction func onRegister() {
        alamofireCodableRegisterUserWith(email: emailOutlet.text!, password: PassOutlet.text!)
        performSegue(withIdentifier: "toHomeVC", sender: nil)

    }
    
    @IBAction func onLogin() {
        loginUserWith(email: emailOutlet.text!, password: PassOutlet.text!)
        performSegue(withIdentifier: "toHomeVC", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    struct UserResponse: Codable {
        let user: User
    }
    
    struct User: Codable {
        let email: String
        let imageUrl: String?
        let id: String
        
        enum CodingKeys: String, CodingKey {
            case email
            case imageUrl = "image_url"
            case id
        }
    }
}
private extension LoginViewController {
    
    func alamofireCodableRegisterUserWith(email: String, password: String) {
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
                case .failure(let error):
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
                    print("Failure: \(error)")
                }
            }
    }
    
    
    //        func handleSuccesfulLogin(for user: User, headers: [String: String]) {
    //            guard let authInfo = try? AuthInfo(headers: headers) else {
    //                infoLabel.text = "Missing headers"
    //                return
    //            }
    //            infoLabel.text = "\(user)\n\n\(authInfo)"
    //        }
}




