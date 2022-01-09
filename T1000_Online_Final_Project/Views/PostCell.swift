//
//  PostCell.swift
//  T1000_Online_Final_Project
//
//  Created by khuloud alshammari on 09/05/1443 AH.
//

import UIKit

class PostCell: UITableViewCell {

    //MARK: ATTRIBUTES
    var tags : [String] = []
    
    //MARK: OUTLETS
    @IBOutlet weak var likesNumberLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var tagsCollectionView: UICollectionView!{
        didSet{
            tagsCollectionView.delegate = self
            tagsCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.layer.shadowColor = UIColor.gray.cgColor
            backView.layer.shadowOpacity = 0.2
            backView.layer.shadowRadius = 10
            backView.layer.shadowOffset = CGSize(width: 0, height: 10)
            backView.layer.cornerRadius = 7
        }
    }
    @IBOutlet weak var userStackView: UIStackView!{
        didSet{
            userStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userStackViewTapped)))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: ACTIONS
    
    @objc func userStackViewTapped(){
        NotificationCenter.default.post(name: NSNotification.Name("userStackViewTapped"), object: nil, userInfo: ["cell": self])
    }
}
    // MARK: EXTENSIONS
extension PostCell : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "PostTagCell", for: indexPath) as! PostTagCell
        
        item.tagNameLabel.text = tags[indexPath.row]
        return item
    }
}
