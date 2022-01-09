//
//  SignInVC.swift
//  T1000_Online_Final_Project
//
//  Created by  khuloud alshammari on 16/05/1443 AH.
//

import UIKit

class SignInVC: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    
    //MARK: LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameText.text! = ""
        lastNameText.text! = ""
        // Do any additional setup after loading the view.
    }
    //MARK: ACTIONS
    @IBAction func logInButtonClicked(_ sender: Any) {
        UserAPI.logInUser(firstName: firstNameText.text!, lastName: lastNameText.text!) { user, errorMessage in
            
            if let message = errorMessage {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }else{
                if let loggedInUser = user {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
                    UserManager.loggedInUser = loggedInUser
                    self.present(vc!, animated: true, completion: nil)
                }
            }
        }
    }
}
