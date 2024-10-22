//
//  ViewController.swift
//  Assignment6V3
//
//  Created by Esha Chiplunkar on 10/21/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let mainScreenView = MainScreenView()
    let notificationCenter = NotificationCenter.default
    let tableViewCell = TableViewCell()
    var contactNames = [String]()
    let detailsController = ContactDetailsControllerViewController()
    
    override func loadView() {
        view = mainScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Contacts"
        
        mainScreenView.tableViewContacts.register(TableViewCell.self, forCellReuseIdentifier: "contacts")
        mainScreenView.tableViewContacts.delegate = self
        mainScreenView.tableViewContacts.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self,
            action: #selector(onAddBarButtonTapped)
        )
        
        let customBackButton = UIBarButtonItem()
        customBackButton.title = "My Contacts"
        navigationItem.backBarButtonItem = customBackButton
        
        getAllContacts()
        
        notificationCenter.addObserver(
                    self,
                    selector: #selector(notificationReceivedForDataChanged(notification:)),
                    name: .dataFromAddContactScreen,
                    object: nil)
        
        notificationCenter.addObserver(
                    self,
                    selector: #selector(notificationReceivedForDataDeleted(notification:)),
                    name: .contactDeleted,
                    object: nil)
        
        notificationCenter.addObserver(
                    self,
                    selector: #selector(notificationReceivedForDataUpdated(notification:)),
                    name: .contactUpdated,
                    object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = mainScreenView.tableViewContacts.indexPathForSelectedRow {
            mainScreenView.tableViewContacts.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @objc func notificationReceivedForDataUpdated(notification: Notification){
        if let userInfo = notification.userInfo,
            let updatedContact = userInfo["updatedContact"] as? Contact,
            let oldContactName = userInfo["oldContactName"] as? String {
                
            if let index = contactNames.firstIndex(of: oldContactName) {
                contactNames[index] = updatedContact.name
                mainScreenView.tableViewContacts.reloadData()
            } else {
                print("Could not find contact with old name")
            }
        } else {
            print("No contact data received")
        }
    }
    
    @objc func notificationReceivedForDataChanged(notification: Notification){
        if let newContact = notification.object as? Contact {
            contactNames.append(newContact.name)
            mainScreenView.tableViewContacts.reloadData()
        }
    }
    
    @objc func notificationReceivedForDataDeleted(notification: Notification){
        if let deletedContact = notification.object as? Contact {
            getAllContacts()
            mainScreenView.tableViewContacts.reloadData()
        } else {
            print("No contact data received")
        }
    }
    
    @objc func onAddBarButtonTapped(){
        let addContactController = AddContactController()
        navigationController?.pushViewController(addContactController, animated: true)
    }
    
    func getAllContacts(){
        if let url = URL(string: APIConfigs.baseURL + "getall"){
            AF.request(url, method: .get).responseString(completionHandler: { response in
        
            let status = response.response?.statusCode
                
            switch response.result{
            case .success(let data):
                    
                if let uwStatusCode = status{
                    switch uwStatusCode{
                        case 200...299:
                            let names = data.components(separatedBy: "\n")
                            self.contactNames = names
                            self.contactNames.removeLast()
                            self.mainScreenView.tableViewContacts.reloadData()
                            print(self.contactNames)
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
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contacts", for: indexPath) as! TableViewCell
        
        let contact = contactNames[indexPath.row]
        cell.labelName.text = contact
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getContactDetails(name: self.contactNames[indexPath.row])
        detailsController.contactName = contactNames[indexPath.row]
        navigationController?.pushViewController(detailsController, animated: true)
    }
    
    func getContactDetails(name: String){
        let parameters = ["name":name]
        if let url = URL(string: APIConfigs.baseURL+"details"){
            AF.request(url, method:.get,
            parameters: parameters,
            encoding: URLEncoding.queryString)
            .responseString(completionHandler: { response in
                    
                let status = response.response?.statusCode
                    
                switch response.result{
                    case .success(let data):
                        if let uwStatusCode = status{
                            switch uwStatusCode{
                                case 200...299:
                                self.detailsController.showDetails(data: data)
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
            }
        }
}

