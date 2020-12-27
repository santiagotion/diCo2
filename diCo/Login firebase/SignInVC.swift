
import UIKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
        @IBOutlet weak var passwordTextField: UITextField!
   
        
        override func viewDidLoad() {
            super.viewDidLoad()
            if #available(iOS 13.0, *) {
                emailTextField.overrideUserInterfaceStyle = .light
                passwordTextField.overrideUserInterfaceStyle = .light
               
            }
            
            
            
            
            
            // Do any additional setup after loading the view.
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
            self.view.addGestureRecognizer(tap)
        }
        
        @objc func handleScreenTap(sender: UITapGestureRecognizer) {
            self.view.endEditing(true)}
        
        
        @IBAction func signInBtn(_ sender: Any) {
            
            guard let email = emailTextField.text , !email.isEmpty ,
                let password = passwordTextField.text , !password.isEmpty else {
                    simpleAlert(title: "Error", msg: "Please fill out all fields.")
                    return
                    
            }
            shouldPresentLoadingView(true)
            
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    debugPrint(error)
                    self.shouldPresentLoadingView(false)
                    self.handleFireAuthError(error: error)
                    return
                }
                self.shouldPresentLoadingView(false)
                self.performSegue(withIdentifier: "toHome1", sender: self)
                print("Loged")
            }
        }
        
        
    //    @IBAction func forgotPass(_ sender: Any) {
    //
    //        let vc = ResetPasswordVC()
    //        vc.modalPresentationStyle = .overCurrentContext
    //        vc.modalTransitionStyle = .crossDissolve
    //        present(vc, animated: true, completion: nil)
    //    }

}
