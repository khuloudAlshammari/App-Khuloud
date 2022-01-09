//
//  User.swift
//  T1000_Online_Final_Project
//
//  Created by khuloud alshammari  on 09/05/1443 AH.
//

import Foundation
import UIKit

struct User : Decodable{
    var id : String
    var firstName : String
    var lastName : String
    var picture : String?
    var phone : String?
    var email : String?
    var gender : String?
    var location : Location?
}
