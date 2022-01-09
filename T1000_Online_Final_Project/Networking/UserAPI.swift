//
//  UserAPI.swift
//  T1000_Online_Final_Project
//
//  Created by khuloud alshammari on 15/05/1443 AH.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class UserAPI : API{
    
    // THIS METHOD USED TO RETIEVE DATA FOR SPECIFIC USER.
    static func getUserData(id : String, completionHandler: @escaping (User) -> ()){
        let url = "\(baseURL)/user/\(id)"
        
        AF.request(url ,headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: jsonData.rawData())
                completionHandler(user)
            }
            catch let error{
                print(error)
            }
            print(jsonData)
        }
    }
    // THIS METHOD USED TO CREATE NEW USER.
    static func getNewUser(firstName: String?, lastName: String?, email: String?, completionHandler: @escaping (User?, String?) -> ()){
        let url = "\(baseURL)/user/create"
        let params =
        [
         "firstName": firstName,
         "lastName": lastName,
         "email" : email
        ]
        
        AF.request(url,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result{
            case .success:
                print("Success")
                let jsonData = JSON(response.value)
                print(jsonData)
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    completionHandler(user, nil)
                }
                catch let error{
                    print(error)
                }
                print(jsonData)
            case .failure (let error):
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                // to replace type from JSON to String
                // Error Messages :
                let emailError = data["email"].stringValue
                let fNameError = data["firstName"].stringValue
                let lNameError = data["lastName"].stringValue
                let errorMessage = emailError + " " + fNameError + " " + lNameError
                 
                completionHandler(nil, errorMessage)
            }
        }
    }
    // THIS METHOD USED TO SIGN IN .
    static func logInUser(firstName: String?, lastName: String?, completionHandler: @escaping (User?, String?) -> ()){
        let url = "\(baseURL)/user"
        let params =
        [
            "created" : "1"
        ]
        // validate to check status if it's between 200 < 300
        AF.request(url,  method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result{
            case .success:
                let jsonData = JSON(response.value)
                let data = jsonData["data"]
                print(jsonData)
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode([User].self, from: data.rawData())
//                    completionHandler(user, nil)
                    var userIsFound = false
                    var foundUser: User?
                    for user in users{
                        if user.firstName == firstName && user.lastName == lastName{
                            foundUser = user
                            break
                        }
                    }
                    if let user = foundUser {
                        completionHandler(user, nil)
                    }else{
                        completionHandler(nil, "The First Name or the Last Name doesn't match any user!")
                    }
                } catch let error{
                    print(error)
                }
            case .failure (let error):
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                // to replace type from JSON to String
                // Error Messages :
                let emailError = data["email"].stringValue
                let fNameError = data["firstName"].stringValue
                let lNameError = data["lastName"].stringValue
                let errorMessage = emailError + " " + fNameError + " " + lNameError
                 
                completionHandler(nil, errorMessage)
            }
        }
}
    static func updateUserInfo(userId: String, firstName: String, phone: String, imageUrl: String, completionHandler: @escaping (User?, String?) -> ()){
        let url = baseURL+"/user/\(userId)"
        let params =
        [
            "firstName" : firstName,
           // "lastName":lastName,
            //"email":email,
            "phone": phone,
            "picture": imageUrl
            
            
        ]
        // validate to check status if it's between 200 < 300
        //MARK: URLEncodedFormParameterEncoder USED TO REPLACE THEM AS QUARY PARAMETER
        //MARK: JSONParameterEncoder USED TO REPLACE THEM AS BODY PARAMETER
        
        AF.request(url,  method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result{
            case .success:
                let jsonData = JSON(response.value!)
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    completionHandler(user, nil)
                } catch let error{
                    print(error)
                }
            case .failure (let error):
                let jsonData = JSON(response.data!)
                let data = jsonData["data"]
                // to replace type from JSON to String
                // Error Messages :
                let emailError = data["email"].stringValue
                let fNameError = data["firstName"].stringValue
                let lNameError = data["lastName"].stringValue
               let errorMessage = emailError + " " + fNameError + " " + lNameError
                 
                completionHandler(nil, emailError)
            }
    
    }
       func saveEdited ( sender : Any){
          guard let loggedInUser = UserManager.loggedInUser else{return}
          let alert = MyProfileVC()
          //  alert.addAction(title:"Done", style:.cancel){ alert in
           // let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar")
                   // UserManager.loggedInUser = loggedInUser
              //     self.present(vc!,animated:true,completionHandler: nil)
            }
          //  self.present(vc!,animated:true,completionHandler: nil)
           
}
}

