//
//  ContactDetailsView.swift
//  Assignment6V3
//
//  Created by Esha Chiplunkar on 10/21/24.
//

import UIKit

class ContactDetailsView: UIView {

    var nameLabel : UILabel!
    var emailLabel : UILabel!
    var phnoLabel : UILabel!
    var deleteButton : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setUpNameLabel()
        setUpEmailLabel()
        setUpPhoneLabel()
        setupbuttonDelete()
        
        initConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = nameLabel.font.withSize(20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
    }
    
    func setUpEmailLabel() {
        emailLabel = UILabel()
        emailLabel.font = emailLabel.font.withSize(20)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailLabel)
    }
    
    func setUpPhoneLabel() {
        phnoLabel = UILabel()
        phnoLabel.font = phnoLabel.font.withSize(20)
        phnoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phnoLabel)
    }
    
        func setupbuttonDelete(){
            deleteButton = UIButton(type: .system)
            deleteButton.setTitle("Delete", for: .normal)
            deleteButton.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(deleteButton)
        }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            nameLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 18),
            
            emailLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 50),
            
            phnoLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            phnoLabel.topAnchor.constraint(equalTo: emailLabel.topAnchor, constant: 36),
            
            deleteButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            deleteButton.topAnchor.constraint(equalTo: phnoLabel.topAnchor, constant: 36)
            
            
        ])
    }
    
    func configure(with contact: Contact) {
        nameLabel.text = "Name: \(contact.name)"
        emailLabel.text = "Email: \(contact.email)"
        phnoLabel.text = "Phone: \(contact.phone)"
    }

}
