//
//  ContactDetailViewController.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 07/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ContactDetailViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = ContactDetailViewModelFactory.create()
    private let updaterViewModel = ContactUpdateViewModelFactory.create()
    private var contactDetail: ContactDetailResponse? = nil
    
    public var contactId: Int = 0
    var isEdit: Bool = false
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getContactDetail()
    }
    
    func getContactDetail() {
        viewModel.contact
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] result  in
                self?.contactDetail = result
                self?.assignContactDetail()
            }).disposed(by: disposeBag)
        
        viewModel.fetchContactDetail(id: contactId)
    }
    
    private func assignContactDetail() {
        let firstName = contactDetail?.fistname ?? ""
        let lastName = contactDetail?.lastname ?? ""
        
        nameLabel.text = firstName + " " + lastName
        firstNameTextField.text = firstName
        lastNameTextField.text = lastName
        mobileTextField.text = contactDetail?.phoneNumber ?? ""
        emailTextField.text = contactDetail?.email ?? ""
    }
    
    @IBAction func editTapped(_ sender: Any) {
        
        isEdit = !isEdit
        if isEdit {
            editButton.setTitle("Done", for: .normal)
            
        } else {
            editButton.setTitle("Edit", for: .normal)
            updaterViewModel.updateContact(id: contactId,
                                           params: updateContact())
        }
        
        firstNameTextField.isEnabled = isEdit
        firstNameTextField.isUserInteractionEnabled = isEdit
    }
    
    func updateContact() -> [String: Any] {
        var params: [String: Any] = [:]
        params = [
            "first_name": firstNameTextField.text ?? "",
            "last_name": lastNameTextField.text ?? "",
            "email": emailTextField.text ?? "",
            "phone_number" : mobileTextField.text ?? ""
        ]
        return params
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
