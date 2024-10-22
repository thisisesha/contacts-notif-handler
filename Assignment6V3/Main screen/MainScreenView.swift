//
//  MainScreenView.swift
//  Assignment6V3
//
//  Created by Esha Chiplunkar on 10/21/24.
//

import UIKit

class MainScreenView: UIView {

    var tableViewContacts : UITableView!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        backgroundColor = .white
                
        setupTableViewContacts()
        initConstraints()
            
    }
        
    func setupTableViewContacts(){
        tableViewContacts = UITableView()
        tableViewContacts.register(TableViewCell.self, forCellReuseIdentifier: "contacts")
        tableViewContacts.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewContacts)
    }
        
    func initConstraints(){
        NSLayoutConstraint.activate([
            tableViewContacts.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewContacts.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewContacts.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewContacts.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}



