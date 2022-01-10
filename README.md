# App-Khuloud
#The application is a program similar to the Twitter application so that a person can share posts and reply to a post
# this code is responsible for logging in the user as a guest
`*func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue"{
            UserManager.loggedInUser = nil*`
  # This code is responsible for adding a new post and an image
  `* func addButtonClicked(_ sender: Any) {
        if let user = UserManager.loggedInUser {
            addButton.setTitle("", for: .normal)
            loaderView.startAnimating()
            PostAPI.addNewPost( imageURL:postImageTextField.text!, text: postTextField.text!, userId: user.id) {
                self.loaderView.stopAnimating()
                self.addButton.setTitle("Add", for: .normal)
                NotificationCenter.default.post(name: NSNotification.Name("NewPostAdded"), object: nil,userInfo: nil)
                self.dismiss(animated: true, completion: nil)*`
                
      `  <img width="332" alt="‏لقطة الشاشة ١٤٤٣-٠٦-٠٧ في ١ ٢٠ ١٧ ص" src="https://user-images.githubusercontent.com/95877163/148755773-27a86706-a8f8-4418-a803-9d1c49ca8e00.png">

        `
# this code is responsible fo alert
`*   var alert = UIAlertController(title:"Notic",message:"To be able to access your profil please log in login",preferredStyle:.alert)
            var action = UIAlertAction(title:"OK",style:.default ) { alert in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC")
              self.present(vc!, animated: true, completion: nil)
            }
            alert.addAction(action)
            self.present(alert,animated:true,completion:nil)*`
        }
    
       
      ` ![Uploading ‏لقطة الشاشة ١٤٤٣-٠٦-٠٧ في ٧.٥٠.٠٩ م.png…]()`
      
# this code is resposile for adding a comment in a post
`* func addNewCommentToPost(postId: String, userId: String, message: String, completionHandler: @escaping () -> ()){
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
     * `
 
`            

https://user-images.githubusercontent.com/95877163/148828788-3b0d1692-6ba5-41a5-8832-f500fc261c11.mov

 `
` <img width="313" alt="‏لقطة الشاشة ١٤٤٣-٠٦-٠٧ في ١٠ ٠٨ ٣٥ م" src="https://user-images.githubusercontent.com/95877163/148825129-01a5f6c6-f4d0-461e-8158-45f279ac0715.png"> ` 
 

# this code is responsible for bringing the tag,and when entering each tag ,you will find all the posts related to this tag
*`func getAllTags(completionHandler: @escaping ([String]) -> ()){
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
    }`*
    
    
  # This video summarizes som of the features of the application
   
    

https://user-images.githubusercontent.com/95877163/148827409-2cd12799-fd2d-4beb-b1af-1f9bb0066d8e.mov

   
    
   

# I have added libraries for this application




https://user-images.githubusercontent.com/95877163/148832835-10001b57-eb49-4c92-95e7-1e93a7081406.mov

