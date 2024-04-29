//
//  PostsTableViewCell.swift
//  PaginationDemo
//
//  Created by Nitu Kumari on 29/04/24.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updatePost(_ post: Posts) {
        
        idLabel.text = String(post.id ?? 0)
        titleLabel.text = post.title
    }
}
