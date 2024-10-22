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
    var contactToEdit: Contact?
    let notificationCenter = NotificationCenter.default
    var edit: Bool = false
    
    override func loadView() {
        view = addContactView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, target: self,
            action: #selector(onSaveBarButtonTapped)
        )
        
        if contactToEdit != nil {
            initializeContactFields()
            edit = true
            title = "Edit Contact"
        } else {
            edit = false
            title = "Add Contact"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        clearAddViewFields()
            
        if edit {
            initializeContactFields()
        }
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    @objc func onSaveBarButtonTapped(){
        
        if let name = addContactView.nameTextField.text,
           let email = addContactView.emailTextField.text,
           let phoneText = addContactView.phnoTextField.text{
            
            if checkEmptyFields() {
                showAlertForEmptyFields()
                return
            }
            
            if !isValidEmail(email) {
                showAlertForInvalidEmail()
                return
            }
                
            let contact = Contact(name: name, email: email, phone: phoneText)
            
            if edit{
                deleteOldContactAndUpdate(contact: contact)
                
            } else {
                addANewContact(contact: contact)
                notificationCenter.post(name: .dataFromAddContactScreen, object: contact)
                navigationController?.popViewController(animated: true)
            }
                    
            } else{
                print("Unable to fetch data")
            }
    }
    
    func initializeContactFields() {
        if let contact = contactToEdit {
            addContactView.nameTextField.text = contact.name
            addContactView.emailTextField.text = contact.email
            addContactView.phnoTextField.text = contact.phone
        }
    }
    
    func deleteOldContactAndUpdate(contact: Contact){
        if let oldContactName = contactToEdit?.name{
            self.deleteContact(name: oldContactName) { success in
                if success {
                    self.addANewContact(contact: contact)
                    let userInfo = ["updatedContact": contact, "oldContactName": oldContactName]
                    self.notificationCenter.post(name: .contactUpdated, object: contact, userInfo: userInfo)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func deleteContact(name: String, completion: @escaping (Bool) -> Void) {
        let parameters = ["name": name]
        
        if let url = URL(string: APIConfigs.baseURL + "delete") {
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString)
                .responseString { response in
                
            let status = response.response?.statusCode
                
            switch response.result {
                case .success(let data):
                    if let uwStatusCode = status {
                        switch uwStatusCode {
                        case 200...299:
                            print("Contact deleted successfully")
                            completion(true)
                            
                        case 400...499:
                            print(data)
                            completion(false)
                            
                        default:
                            print(data)
                            completion(false)
                        }
                    } else {
                        completion(false)
                    }
                    
                case .failure(let error):
                    print(error)
                    completion(false)
                }
            }
        } else {
            completion(false)
        }
    }
    
    
    func addANewContact(contact: Contact){
        if let url = URL(string: APIConfigs.baseURL+"add"){
            
        AF.request(url, method:.post, parameters:
            [
                "name": contact.name,
                "email": contact.email,
                "phone": contact.phone
            ])
            .responseString(completionHandler: { response in
                    
            let status = response.response?.statusCode
                    
            switch response.result{
                case .success(let data):
        
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                            case 200...299:
                               print("Contact added successfully")
                                break
                        
                            case 400...499:
                                print(data)
                                break
                        
                            default:
                                print(data)
                                break
                        }
                    }
                    break
                        
                case .failure(let error):
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
