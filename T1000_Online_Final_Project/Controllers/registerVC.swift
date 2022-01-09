//
//  registerVC.swift
//  T1000_Online_Final_Project
//
//  Created by  khuloud alshammari on 15/05/1443 AH.
//

import UIKit

class registerVC: UIViewController {

    //MARK: OUTLETS
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: ACTIONS
    @IBAction func registerButtonCliked(_ sender: Any) {
        
        UserAPI.getNewUser(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailTextField.text!) { user,errorMessage  in
            if errorMessage != nil {
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Success", message: "User Created", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
         
}

