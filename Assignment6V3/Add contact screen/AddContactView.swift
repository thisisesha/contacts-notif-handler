//
//  AddContactView.swift
//  Assignment6V3
//
//  Created by Esha Chiplunkar on 10/21/24.
//

import UIKit

class AddContactView: UIView {

    var nameTextField : UITextField!
    var emailTextField : UITextField!
    var phnoTextField : UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setUpNameTextField()
        setUpEmailTextField()
        setUpPhnoTextField()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpNameTextField() {
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameTextField)
    }

    func setUpEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailTextField)
    }
    
    func setUpPhnoTextField() {
        phnoTextField = UITextField()
        phnoTextField.placeholder = "Phone number"
        phnoTextField.borderStyle = .roundedRect
        phnoTextField.translatesAutoresizingMaskIntoConstraints = false
        phnoTextField.keyboardType = .phonePad
        self.addSubview(phnoTextField)
    }
    
    func initConstraints() {
        
        NSLayoutConstraint.activate([
                
            nameTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            nameTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            emailTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            phnoTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            phnoTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            phnoTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            phnoTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                
        ])
    }


}
