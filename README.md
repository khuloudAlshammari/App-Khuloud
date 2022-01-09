# App-Khuloud
The application is a program similar to the Twitter application so that a person can share posts and reply to a post
this code is responsible for logging in the user as a guest
func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue"{
            UserManager.loggedInUser = nil
