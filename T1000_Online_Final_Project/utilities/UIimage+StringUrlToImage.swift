//
//  UIimage+StringUrlToImage.swift
//  T1000_Online_Final_Project
//
//  Created by  khuloud alshammari on 13/05/1443 AH.
//

import Foundation
import UIKit

extension UIImageView {
   
    func convertImageFromStringUrl(stringOfUrl : String){
        if let url = URL(string: stringOfUrl){
            if let imageData = try? Data(contentsOf: url){
                self.image = UIImage(data: imageData)
            }
        }
    }
    func makeCircularImage(){
        self.layer.cornerRadius = self.frame.width/2
        
    }
}
