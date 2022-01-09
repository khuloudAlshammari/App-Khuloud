//
//  ViewController.swift
//  T1000_Online_Final_Project
//
//  Created by khuloud alshammari on 09/05/1443 AH.
//

import UIKit
import NVActivityIndicatorView

class PostsVC: UIViewController {

    //MARK: OUTLETS
    
    @IBOutlet weak var newPostButtonContainerView: ShadowView!
    @IBOutlet weak var closeButtonLabel: UIButton!
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var tagContainerView: UIView!
    @IBOutlet weak var loaderActivityIndictor: UIActivityIndicatorView!
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var hiLabel: UILabel!
    
    //MARK: ATTRIBUTES
    var total = 0
    var page = 0
    var posts : [Post] = []
    var tag: String?
    
    //MARK: LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(newPostAdded), name: NSNotification.Name("NewPostAdded"), object: nil)
        tagContainerView.layer.cornerRadius = 10
        tagNameLabel.layer.cornerRadius = 10
        hiLabel.layer.cornerRadius = 10
        // CHECK IF USER S LOGGED IN OR IT'S ONLY A GUEST
        if let user = UserManager.loggedInUser {
            hiLabel.text = "Hi, \(user.firstName)"
        }else{
            hiLabel.isHidden = true
            newPostButtonContainerView.isHidden = true
        }
        
        //MARK: CHECK IF THERE IS TAG!
        if let myTag = tag {
            tagNameLabel.text = myTag
        }else{
            closeButtonLabel.isHidden = true
            tagContainerView.isHidden = true
        }
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        // subscribing to the notification
        NotificationCenter.default.addObserver(self, selector: #selector(userProfile), name: NSNotification.Name("userStackViewTapped"), object: nil)
            getPosts()
        }
    func getPosts(){
        loaderActivityIndictor.startAnimating()
        PostAPI.getAllPosts(page: page, tag: tag) { postsResponse, total in
            self.loaderActivityIndictor.isHidden = true
            self.total = total
    //MARK: WHEN WE USE self.posts = postsResponse THAT WILL MAKE PROBLEM BECAUSE EVERYTIME WE CALL THIS METHOD WILL REPLACE THE posts ARRAY WITH postsResponse VALUES THEN TO FIXED WE CAN SOLVE BY ADD THE VALUES INTO posts ARRAY BY USING :
            self.posts.append(contentsOf: postsResponse)
            self.postsTableView.reloadData()
            self.loaderActivityIndictor.stopAnimating()
    }
    }
    
    @objc func newPostAdded(){
        self.posts = []
        self.page = 0
        getPosts()
    }
    // MARK: ACTIONS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue"{
            UserManager.loggedInUser = nil
        }
    }
    @IBAction func signOutButtonClicked(_ sender: Any) {
              UserManager.loggedInUser = nil
        dismiss(animated: true, completion: nil)
    }
    @IBAction func backButtonClicked(_ sender: Any) {
       
        dismiss(animated: true, completion: nil)
    }
    @objc func userProfile(notification: Notification){
        if let cell = notification.userInfo?["cell"] as? UITableViewCell{
            if let indexPath = postsTableView.indexPath(for: cell){
            let post = posts[indexPath.row]
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                vc.user = post.owner
            present(vc, animated: true, completion: nil)
        }
        }
        
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewPostVC")
        present(vc!, animated: true, completion: nil)
    }
}
    //MARK: EXTENSIONS
extension PostsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // To determine number of cells by using count of array
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        cell.postTextLabel.text = post.text
        // the logic of filling the post's image from the URL
        let imageStringUrl = post.image
        if let url = URL(string: imageStringUrl){
            if let imageData = try? Data(contentsOf: url){
                cell.postImageView.image = UIImage(data: imageData)
            }
        }
        //the logic of filling the user's image from the URL
        let userImageStringUrl = post.owner.picture
        cell.userImageView.makeCircularImage()
        
        if let image = userImageStringUrl{
            cell.userImageView.convertImageFromStringUrl(stringOfUrl: image)
        }
        // filling the user data
        cell.userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        cell.likesNumberLabel.text = String(post.likes)
        
        cell.tags = post.tags ?? []
        
        return cell
    }
    //MARK: THIS METHOD RETRIVEVE THE SIZE OF THE CELL
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 520
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPost = posts[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostDetailsVC") as! PostDetailsVC
        vc.post = selectedPost
        present(vc, animated: true, completion: nil)
    }
    
    //MARK: THIS FUNCTION IS USED TO NOTIFY YOU THAT THE LAST CELL HAS BEEN REACHED
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //MARK: WE CAN USE TOTAL TO CHECK IF THE TOTAL OF ITEMS LESS THAN THE LIMIT THEN NO NEED TO MOVE TO THE NEXT PAGE
        if indexPath.row == posts.count - 1 && posts.count < total{
            page = page + 1
            getPosts()
        }
    }
}

