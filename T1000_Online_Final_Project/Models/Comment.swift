//
//  Comment.swift
//  T1000_Online_Final_Project
//
//  Created by khuloud alshammari on 13/05/1443 AH.
//

import Foundation
struct Comment: Decodable{
    var id : String
    var message : String
    var owner : User
}

/*  NOTES:

1) Table View -> Cells

2) Collection View -> Items
    Section Insets -> Constraints of the items

*/
