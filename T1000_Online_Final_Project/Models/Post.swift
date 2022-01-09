//
//  Post.swift
//  T1000_Online_Final_Project
//
//  Created by khuloud alshammari on 09/05/1443 AH.
//

import Foundation
import UIKit

struct Post : Decodable{
    
    var id : String
    var image : String
    var likes : Int
    var text : String
    var owner : User
    var tags : [String]?
}
