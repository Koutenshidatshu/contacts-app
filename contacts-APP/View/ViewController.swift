//
//  ViewController.swift
//  contacts-APP
//
//  Created by Yonathan Wijaya on 05/08/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = ContactListViewModelFactory.create()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        bindingViewModel()
    }
    
    private func registerCell() {
        tableView.register(UINib.init(nibName: "ContactsTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
    
    }
    
    private func bindingViewModel() {
        viewModel.contact
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.viewLoad()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getContactount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactsTableViewCell
        cell?.setup(contact: viewModel.itemAt(index: indexPath.row))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

