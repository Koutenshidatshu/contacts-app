//
//  ContactsTableViewCell.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 07/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit
import Nuke
class ContactsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePict: UIImageView!
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    } 
    
    func setup(contact: ContactsListResponse?) {
        guard let unwrapContact = contact else { return }
        nameLabel.text = unwrapContact.fistname! + " " + unwrapContact.lastname!
        
        if unwrapContact.favorite! {
            favoriteIcon.image = UIImage(named: "home_favourite")
        } else {
            favoriteIcon.image = UIImage(named: "favourite_button")
        }
        
        guard let imageURL = URL(string: unwrapContact.profilepic!), !unwrapContact.profilepic!.contains("missing") else { return }
        
        loadImage(with: imageURL, into: profilePict)
    }
}
