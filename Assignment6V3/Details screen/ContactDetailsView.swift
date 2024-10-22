//
//  ContactDetailsView.swift
//  Assignment6V3
//
//  Created by Esha Chiplunkar on 10/21/24.
//

import UIKit

class ContactDetailsView: UIView {

    var contentWrapper: UIScrollView!
    var nameLabel : UILabel!
    var emailLabel : UILabel!
    var phnoLabel : UILabel!
    var deleteButton : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupContentWrapper()
        setUpNameLabel()
        setUpEmailLabel()
        setUpPhoneLabel()
        setupbuttonDelete()
        
        initConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
    }
    
    func setUpEmailLabel() {
        emailLabel = UILabel()
        emailLabel.font = emailLabel.font.withSize(18)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailLabel)
    }
    
    func setUpPhoneLabel() {
        phnoLabel = UILabel()
        phnoLabel.font = phnoLabel.font.withSize(18)
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
            
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            nameLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 50),
            
            emailLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 45),
            
            phnoLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            phnoLabel.topAnchor.constraint(equalTo: emailLabel.topAnchor, constant: 45),
            
            deleteButton.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            deleteButton.topAnchor.constraint(equalTo: phnoLabel.topAnchor, constant: 50),
            deleteButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func configure(with contact: Contact) {
        nameLabel.text = "\(contact.name)"
        emailLabel.text = "Email: \(contact.email)"
        phnoLabel.text = "Phone: \(contact.phone)"
    }

}
