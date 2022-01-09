////  PostAPI.swift
//  T1000_Online_Final_Project
//
//  Created by khuloud alshammari on 15/05/1443 AH.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON


class PostAPI : API {
    
    // MARK: NOTES
    // ESCAPING using with completionHandler and be WITHIN the lines of code
    // COMPLETIONHANDLER is method (function) called in one place and built in another
    
    // MARK: METHODS
    
    // THIS METHOD USED TO RETIEVE ALL POSTS.
    static func getAllPosts(page: Int, tag: String?, completionHandler: @escaping ([Post],Int) -> ()){
        
        // MARK: YOU CAN ADD THE QUERIES TO THE URL BY WRITE "?" AFTER POST LIKE => POST?PAGE=1 OR YOU CAN USE URLEncoderFormParameterEncoder.default
        
        var url = "\(baseURL)/post"

        if var myTag = tag {
            myTag = myTag.trimmingCharacters(in: .whitespaces)
            url = "\(baseURL)/tag/\(myTag)/post"
        }
        let params = [
            "page": "\(page)",
            "limit": "5"
        ]
        
        AF.request(url,parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseJSON { response in
            
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            //MARK: TO RETRIEVE THE TOTAL OF ITEMS INTO THIS TAG
            let total = jsonData["total"].intValue
            let decoder = JSONDecoder()
            do {
                let posts = try decoder.decode([Post].self, from: data.rawData())
                completionHandler(posts,total)
            }
            catch let error{
                print(error)
            }
            print(data)
        }
    }
    // THIS METHOD USED TO ADD NEW POST.
    static func addNewPost(imageURL:String,text: String, userId: String, completionHandler: @escaping () -> ()){
        let url = baseURL + "/post/create"
        let params =
        [
         "owner": userId,
         "text": text,
         "image": imageURL
        ]
        
        AF.request(url,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result{
            case .success:
                
                completionHandler()
            case .failure (let error):
                print(error)
        }
    }
    }
    
    // THIS METHOD USED TO RETIEVE ALL COMMENT OF SPECIFIC POST.
    static func getPostComments(id : String, completionHandler: @escaping ([Comment]) -> ()){
        let url = "\(baseURL)/post/\(id)/comment"
        AF.request(url, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            
            let decoder = JSONDecoder()
            do {
                let comments = try decoder.decode([Comment].self, from: data.rawData())
                completionHandler(comments)
            }
            catch let error{
                print(error)
            }
        }
    }
    //MARK: COMMENT API
    // THIS METHOD USED TO ADD NEW COMMENT OF SPECIFIC POST.
    static func addNewCommentToPost(postId: String, userId: String, message: String, completionHandler: @escaping () -> ()){
        let url = "\(baseURL)/comment/create"
        let params =
        [
         "post": postId,
         "message": message,
         "owner" : userId
        ]
        AF.request(url,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result{
            case .success:
                completionHandler()
            case .failure (let error):
                print(error)
        }
    }
    }
    
    // THIS METHOD USED TO CREATE POST.
    static func createPost(postId: String, userId: String, message: String, completionHandler: @escaping () -> ()){
        let url = "\(baseURL)/comment/create"
        let params =
        [
         "post": postId,
         "message": message,
         "owner" : userId
        ]
        AF.request(url,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result{
            case .success:
                completionHandler()
            case .failure (let error):
                print(error)
        }
    }
    }
    //MARK: TAG API
    // THIS METHOD USED TO RETRIEVE ALL TAGS.
    static func getAllTags(completionHandler: @escaping ([String]) -> ()){
        let url = "\(baseURL)/tag"
        AF.request(url, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do {
                let tags = try decoder.decode([String].self, from: data.rawData())
                completionHandler(tags)
            }
            catch let error{
                print(error)
            }
            print(data)
        }
    }
}
