//
//  ContactDetailsControllerViewController.swift
//  Assignment6V3
//
//  Created by Esha Chiplunkar on 10/21/24.
//

import UIKit
import Alamofire

class ContactDetailsControllerViewController: UIViewController {

    var contact = Contact(name: "", email: "", phone: "")
    var contactName: String?
    
    let detailsView = ContactDetailsView()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contact Details"
     
        self.view.backgroundColor = .white
        
        detailsView.deleteButton.addTarget(self, action: #selector(onDeleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func onDeleteButtonTapped() {
        let alert = UIAlertController(title: "Delete Contact", message: "Are you sure you want to delete this contact?",
                                      preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
                if let uwname = self.contactName {
                print(uwname)
                self.deleteContact(name: uwname) { isDeleted in
                    if isDeleted {
                        print("Deleted contact name: \(uwname)") 
                        self.notificationCenter.post(name: .contactUpdated, object: self.contact)
                        self.navigationController?.popViewController(animated: true)
                } else {
                    print("Could not delete!")
                }
            }
        }
                
    }))
            
        present(alert, animated: true, completion: nil)
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
    
    func showDetails(data: String) {
        let parts = data.components(separatedBy: ",")
        print(parts)
            
        let name = parts[0].trimmingCharacters(in: .whitespacesAndNewlines)
        let email = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
        let phone = parts[2].trimmingCharacters(in: .whitespacesAndNewlines)
        
        let contact = Contact(name: name, email: email, phone: phone)
        detailsView.configure(with: contact)
    
    }
    
}
