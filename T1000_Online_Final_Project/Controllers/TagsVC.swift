//
//  TagsVC.swift
//  T1000_Online_Final_Project
//
//  Created by  khuloud alshammari on 19/05/1443 AH.
//

import UIKit

class TagsVC: UIViewController {

    //MARK: ATTRIBUTES
    var tags = ["A","B","C","D","E","F"]
    
    //MARK: OUTLETS
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var loaderActivityIndictor: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self

        loaderActivityIndictor.startAnimating()
        PostAPI.getAllTags { tags in
            self.loaderActivityIndictor.isHidden = true
            self.tags = tags
            self.tagsCollectionView.reloadData()
            
        }
        
    }
    
    @IBAction func signOutButtonClicked(_ sender: Any) {
        UserManager.loggedInUser = nil
        dismiss(animated: true, completion: nil)
    }
}

extension TagsVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var item = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        
        let currenTag = tags[indexPath.row]
        item.tagNameLabel.text = currenTag
        
        return item
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTag = tags[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostsVC") as! PostsVC
        vc.tag = selectedTag
        self.present(vc, animated: true, completion: nil)
    }
   
}
