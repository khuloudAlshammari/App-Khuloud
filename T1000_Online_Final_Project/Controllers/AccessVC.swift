//
//  AccessVC.swift
//  T1000_Online_Final_Project
//
//  Created by زياد الحربي on 15/05/1443 AH.
//

import UIKit

class AccessVC: UIViewController {

    //MARK: OUTLETS
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: ATTRIBUTES
    var password = "khuloud"
    
    //MARK: LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTextField.text = "khuloud"
        // Do any additional setup after loading the view.
    }
    @IBAction func enterButtonCliked(_ sender: Any) {
        if passwordTextField.text != password {
            let alert = UIAlertController(title: "  تنبيه ! ", message: "كلمة السر خاطئة", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "تم", style: .cancel, handler: nil)
            alert.addAction(closeAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        else{
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostsVC") as! PostsVC
        present(vc, animated: true, completion: nil)
        }
    }
}
