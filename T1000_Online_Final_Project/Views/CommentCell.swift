//
//  CommentCell.swift
//  T1000_Online_Final_Project
//
//  Created by khuloud alshammari on 13/05/1443 AH.
//

import UIKit

class CommentCell: UITableViewCell {

    //MARK: OUTLETS
    @IBOutlet weak var commentMessageLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
