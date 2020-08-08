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
    weak var delegate: HomeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getContactDetail()
        
        setupTextField(isEditing: false)
        
        let tap = UITapGestureRecognizer(target: self.view,
                                         action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func getContactDetail() {
        viewModel.contact
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] result  in
                self?.contactDetail = result
                self?.assignContactDetail()
            }).disposed(by: disposeBag)
        
        viewModel.fetchContactDetail(id: contactId)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.backTriggered()
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
            DispatchQueue.main.async {
                self.firstNameTextField.becomeFirstResponder()
            }
            
        } else {
            editButton.setTitle("Edit", for: .normal)
            updaterViewModel.updateContact(id: contactId,
                                           params: updateContact())
        }
        setupTextField(isEditing: isEdit)
    }
    
    private func setupTextField(isEditing: Bool) {
        firstNameTextField.isEnabled = isEditing
        firstNameTextField.isUserInteractionEnabled = isEditing
        lastNameTextField.isEnabled = isEditing
        lastNameTextField.isUserInteractionEnabled = isEditing
        emailTextField.isEnabled = isEditing
        emailTextField.isUserInteractionEnabled = isEditing
        mobileTextField.isEnabled = isEditing
        mobileTextField.isUserInteractionEnabled = isEditing
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
        let phoneNumber = mobileTextField.text ?? ""
        if let url = URL(string: "tel://\(phoneNumber)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    
    @IBAction func messageTapped(_ sender: Any) {
        
    }
    
    @IBAction func emailTapped(_ sender: Any) {
        
    }
    @IBAction func favoriteTapped(_ sender: Any) {
        
    }
    
}
