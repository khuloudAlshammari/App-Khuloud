//
//  NewPostVC.swift
//  T1000_Online_Final_Project
//
//  Created by khuloud alshammari on 21/05/1443 AH.
//

import UIKit

class NewPostVC: UIViewController {

    @IBOutlet weak var postTextField: UITextField!
    @IBOutlet weak var postImageTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addButtonClicked(_ sender: Any) {
        if let user = UserManager.loggedInUser {
            addButton.setTitle("", for: .normal)
            loaderView.startAnimating()
            PostAPI.addNewPost( imageURL:postImageTextField.text!, text: postTextField.text!, userId: user.id) {
                self.loaderView.stopAnimating()
                self.addButton.setTitle("Add", for: .normal)
                NotificationCenter.default.post(name: NSNotification.Name("NewPostAdded"), object: nil,userInfo: nil)
                self.dismiss(animated: true, completion: nil)
        }
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
