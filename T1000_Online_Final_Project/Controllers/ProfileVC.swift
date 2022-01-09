//
//  ProfileVCViewController.swift
//  T1000_Online_Final_Project
//
//  Created by khuloud alshammari on 14/05/1443 AH.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class ProfileVC: UIViewController {

    var user: User!
    
    //MARK: OUTLETS
    @IBOutlet weak var loaderActivityIndictor: UIActivityIndicatorView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!{
        didSet{
            profileImageView.makeCircularImage()
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var counrtyLabel: UILabel!
    
    //MARK: LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        loaderActivityIndictor.isHidden = false
        loaderActivityIndictor.startAnimating()
        setupUI()
        
        let appId = "61d82f5a27255b92c9fcb7bb"
        let url = "https://dummyapi.io/data/v1/user/\(user.id)"
        
        let headers: HTTPHeaders = [
            "app-id" : appId
        ]
        AF.request(url, headers: headers).responseJSON { response in
           // self.loaderView.startAnimating()
            
            let jsonData = JSON(response.value)
            let decoder = JSONDecoder()
            do {
               // self.loaderActivityIndictor.stopAnimating()
               // self.loaderActivityIndictor.isHidden = true
                self.user = try decoder.decode(User.self, from: jsonData.rawData())
                self.setupUI()
                self.loaderActivityIndictor.stopAnimating()
            }
            catch let error{
                print(error)
            }
            print(jsonData)
        }
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        nameLabel.text = user.firstName + " " + user.lastName
        profileImageView.convertImageFromStringUrl(stringOfUrl: user.picture!)
        profileImageView.makeCircularImage()
        genderLabel.text = user.gender
//        print(genderLabel.text)
        emailLabel.text = user.email
//        print(emailLabel.text)
        phoneLabel.text = user.phone
//        print(phoneLabel.text)
        
        if let location = user.location {
            counrtyLabel.text = location.country! + " - " + location.city!
        }
        if let image = user.picture{
            profileImageView.convertImageFromStringUrl(stringOfUrl: image)
        }
    }
    
}
