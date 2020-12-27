

import UIKit
import Firebase

class SignUpVC: UIViewController {

    @IBOutlet weak var emailTextFieldq: UITextField!
    @IBOutlet weak var passwordTextFieldq: UITextField!
   

    
    
              override func viewDidLoad() {
        super.viewDidLoad()
                emailTextFieldq.overrideUserInterfaceStyle = .light
                passwordTextFieldq.overrideUserInterfaceStyle = .light
        
        
       
     
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)}
    
    
        
        
    
    
    
    
    
    @IBAction func signUpBtkn(_ sender: Any) {
        
        guard let email = emailTextFieldq.text , !email.isEmpty ,
            let password = passwordTextFieldq.text , !password.isEmpty else {
                simpleAlert(title: "Error", msg: "Please fill out all fields.")
                return
                
        }
        
        
        
        shouldPresentLoadingView(true)
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            if let error = error {
                debugPrint(error)
                self.handleFireAuthError(error: error)
                self.shouldPresentLoadingView(false)
                return
            }
            

            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let databaseRef = Database.database().reference().child("users/\(uid)")
            
            let userObject = [
                "email": self.emailTextFieldq.text!
                
                
                ] as [String:Any]
            
            databaseRef.updateChildValues(userObject)
            
                self.shouldPresentLoadingView(false)
                self.performSegue(withIdentifier: "toPhotoUpload", sender: self)
        }
    }


}
