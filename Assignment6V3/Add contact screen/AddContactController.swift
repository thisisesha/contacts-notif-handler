//
//  AddContactController.swift
//  Assignment6V3
//
//  Created by Esha Chiplunkar on 10/21/24.
//

import UIKit
import Alamofire

class AddContactController: UIViewController {

    let addContactView = AddContactView()
    var contacts = [Contact]()
    let mainScreenController = ViewController()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = addContactView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Contact"

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, target: self,
            action: #selector(onSaveBarButtonTapped)
        )
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    @objc func onSaveBarButtonTapped(){
        
        
        if let email = addContactView.emailTextField.text {
            if !isValidEmail(email) {
                showAlertForInvalidEmail()
                return
            }
        }
        
        if let name = addContactView.nameTextField.text,
           let email = addContactView.emailTextField.text,
           let phoneText = addContactView.phnoTextField.text{
            
            if !isValidEmail(email) {
                showAlertForInvalidEmail()
                return
            }
                
                
            let contact = Contact(name: name, email: email, phone: phoneText)
                    
                    //MARK: call add a new contact API endpoint...
                    addANewContact(contact: contact)
                    notificationCenter.post(
                        name: .dataFromAddContactScreen,
                        object: contact)
                    navigationController?.popViewController(animated: true)
                    
                }
            
            else{
                if checkEmptyFields() {
                    showAlertForEmptyFields()
                    return
                }
            }
       
        
    }
    
    //MARK: add a new contact call: add endpoint...
    func addANewContact(contact: Contact){
        if let url = URL(string: APIConfigs.baseURL+"add"){
            
            AF.request(url, method:.post, parameters:
                        [
                            "name": contact.name,
                            "email": contact.email,
                            "phone": contact.phone
                        ])
                .responseString(completionHandler: { response in
                    //MARK: retrieving the status code...
                    let status = response.response?.statusCode
                    
                    switch response.result{
                    case .success(let data):
                        //MARK: there was no network error...
                        
                        //MARK: status code is Optional, so unwrapping it...
                        if let uwStatusCode = status{
                            switch uwStatusCode{
                                case 200...299:
                                //MARK: the request was valid 200-level...
                                self.mainScreenController.getAllContacts()
                                self.clearAddViewFields()
                                    break
                        
                                case 400...499:
                                //MARK: the request was not valid 400-level...
                                    print(data)
                                    break
                        
                                default:
                                //MARK: probably a 500-level error...
                                    print(data)
                                    break
                        
                            }
                        }
                        break
                        
                    case .failure(let error):
                        //MARK: there was a network error...
                        print(error)
                        break
                    }
                })
        }else{
            showAlertForInvalidURL()
        }
        
    }
    
    func clearAddViewFields(){
        addContactView.nameTextField.text = ""
        addContactView.emailTextField.text = ""
        addContactView.phnoTextField.text = ""
    }
    
    func checkEmptyFields() -> Bool {
        if addContactView.nameTextField.text?.isEmpty == true ||
            addContactView.emailTextField.text?.isEmpty == true ||
            addContactView.phnoTextField.text?.isEmpty == true {
            return true
        }
        return false
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return emailPred.evaluate(with: email)
    }
    
    func showAlertForInvalidEmail() {
        let alert = UIAlertController(title: "Error!", message: "Invalid Email Id!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
    func showAlertForEmptyFields() {
        let alert = UIAlertController(title: "Error!", message: "All fields are mandatory!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
    func showAlertForInvalidPhone() {
        let alert = UIAlertController(title: "Error!", message: "Invalid Phone number!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
    func showAlertForInvalidURL() {
        let alert = UIAlertController(title: "Error!", message: "Invalid URL!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }


}
