//
//  MyProfileVC.swift
//  T1000_Online_Final_Project
//
//  Created by khuloud alshammari onياد  21/05/1443 AH.
//

import UIKit
import NVActivityIndicatorView

class MyProfileVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imagView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var imageUrlTextField: UITextField!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  loaderActivityIndictor.startAnimating()
        firstNameTextField.isEnabled = true
       phoneTextField.isEnabled = true
       imageUrlTextField.isEnabled = true
        setupUI()
      // loaderActivityIndictor.stopAnimating()
        
        
        // Do any additional setup after loading the view.
    }
    func setupUI(){
       // imagView.makeCircularImage()
        if let user = UserManager.loggedInUser {
           imagView.makeCircularImage()
            if let image = user.picture {
                imagView.convertImageFromStringUrl(stringOfUrl: image)
            }
            nameLabel.text = user.firstName + " " + user.lastName
            firstNameTextField.text = user.firstName
            phoneTextField.text = user.phone
            imageUrlTextField.text = user.picture
        }
    }
        
    @IBAction func submitButtonClicked(_ sender: Any) {
        guard let loggendin = UserManager.loggedInUser else{ return }
        
        UserAPI.updateUserInfo(userId: loggendin.id, firstName: firstNameTextField.text!, phone: phoneTextField.text!, imageUrl: imageUrlTextField.text!) { user, message in
                     // self.loaderView.stopAnimating()
            if let reponseUser = user {
                if let image = user?.picture{
                self.imagView.convertImageFromStringUrl(stringOfUrl: image)
            }
                self.nameLabel.text = reponseUser.firstName + " " + reponseUser.lastName
                self.phoneTextField.text = reponseUser.phone
            }
        }
        var alert = UIAlertController(title:"أشعار",message:"تم التعديل",preferredStyle:.alert)
        var action = UIAlertAction(title:"OK",style:.default ,handler:nil)
        alert.addAction(action)
        present(alert,animated:true,completion:nil)
    }
}
