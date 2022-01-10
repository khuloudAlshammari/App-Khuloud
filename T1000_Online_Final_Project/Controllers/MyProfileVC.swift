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
     var user : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  loaderActivityIndictor.startAnimating()
        firstNameTextField.isEnabled = true
       phoneTextField.isEnabled = true
       imageUrlTextField.isEnabled = true
        setupUI()
      // loaderActivityIndictor.stopAnimating()
        if let userLogged = UserManager.loggedInUser {
            // imagView.makeCircularImage()
            UserAPI.getUserData(id: userLogged.id) { UserResponse in
                self.user = UserResponse
                self.setupUI()
            }
            
        } else {
            nameLabel.text = ""
            firstNameTextField.text = ""
            phoneTextField.text  = ""
            imageUrlTextField.text = ""
            
            var alert = UIAlertController(title:"Notic",message:"To be able to access your profil please log in login",preferredStyle:.alert)
            var action = UIAlertAction(title:"OK",style:.default ) { alert in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC")
              self.present(vc!, animated: true, completion: nil)
            }
            alert.addAction(action)
            self.present(alert,animated:true,completion:nil)
        }
    
        

        
        // Do any additional setup after loading the view.
    }
    func setupUI(){
       // imagView.makeCircularImage()
      //  if let user = UserManager.loggedInUser {
        //   imagView.makeCircularImage()
          if let image = user?.picture {
                imagView.convertImageFromStringUrl(stringOfUrl: image)
            }
        if user?.firstName != nil && user?.lastName != nil {
            nameLabel.text = user.firstName + " " + user.lastName}
        if user?.firstName != nil{
            firstNameTextField.text = user.firstName}
        if user?.phone != nil{
            firstNameTextField.text = user.phone}
        if user?.picture != nil{
        
            imageUrlTextField.text = user.picture}
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
