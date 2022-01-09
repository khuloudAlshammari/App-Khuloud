//
//  PostDetailsVC.swift
//  T1000_Online_Final_Project
//
//  Created by khuloud alshammari on 12/05/1443 AH.
//
import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class PostDetailsVC: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var loaderActivityIndictor: UIActivityIndicatorView!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
     @IBOutlet weak var postImageView: UIImageView!
     @IBOutlet weak var exitButton: UIButton!
     @IBOutlet weak var numberOfLikesLabel: UILabel!
     @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var newCommentStackView: UIStackView!
    
    //MARK: ATTRIBUTES
     var post : Post!
     var comments: [Comment] = []

     //MARK: LIFE CYCLE METHODS
     override func viewDidLoad() {
        super.viewDidLoad()
        
         if UserManager.loggedInUser == nil {
             newCommentStackView.isHidden = true
         }
         
        commentTableView.delegate = self
        commentTableView.dataSource = self
        exitButton.layer.cornerRadius = exitButton.frame.width/22
        userNameLabel.text =  post.owner.firstName + " " + post.owner.lastName
        postTextLabel.text = post.text
        numberOfLikesLabel.text = String(post.likes)
         
         if let image = post.owner.picture {
             userImageView.convertImageFromStringUrl(stringOfUrl: image)
         }
        userImageView.makeCircularImage()
        postImageView.convertImageFromStringUrl(stringOfUrl: post.image)

         // getting the comments of the post from the API
         
         loaderActivityIndictor.startAnimating()
         getPostComments()

         }
     func getPostComments(){
         loaderActivityIndictor.startAnimating()
         PostAPI.getPostComments(id: post.id) { commentsResponse in
             self.loaderActivityIndictor.isHidden = true
             self.comments = commentsResponse
             self.commentTableView.reloadData()
             self.loaderActivityIndictor.stopAnimating()
         }
     }

    
     @IBAction func exitButtonCliked(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
     }
    
    @IBAction func sendCommentClicked(_ sender: Any) {
        let message = commentTextField.text!
        if let user = UserManager.loggedInUser {
            loaderActivityIndictor.startAnimating()
            PostAPI.addNewCommentToPost(postId: post.id, userId: user.id, message: message) {
                self.getPostComments()
                self.commentTextField.text = ""
        }
        }
    }
}
 extension PostDetailsVC : UITableViewDelegate,UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        
        let currentComment = comments[indexPath.row]
        
        cell.userNameLabel.text = currentComment.owner.firstName + " " + currentComment.owner.lastName
        cell.commentMessageLabel.text = currentComment.message
        if let userImage = currentComment.owner.picture {
        cell.userImageView.convertImageFromStringUrl(stringOfUrl: userImage)
        }
        cell.userImageView.makeCircularImage()
        return cell
     }

 }
