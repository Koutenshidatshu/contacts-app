//
//  ContactDetailViewController.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 07/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    public var contactId: Int = 0
    var isEdit: Bool = false
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func editTapped(_ sender: Any) {
        
        isEdit = !isEdit
        if isEdit {
            editButton.setTitle("Done", for: .normal)
     
        } else {
            editButton.setTitle("Edit", for: .normal)
            //send to api for update
        }
        
        firstNameTextField.isEnabled = isEdit
        firstNameTextField.isUserInteractionEnabled = isEdit
    }
    
    @IBAction func callTapped(_ sender: Any) {
    }
    
    @IBAction func messageTapped(_ sender: Any) {
    }
    
    @IBAction func emailTapped(_ sender: Any) {
        
    }
    @IBAction func favoriteTapped(_ sender: Any) {
        
    }
    
}
