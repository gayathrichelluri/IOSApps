//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Properties for the navigation bar
        title = K.appName
        navigationItem.hidesBackButton =  true
        
        //set delegates/dataSources as self
        tableView.dataSource = self
        
        //set the newly created reusable cell to the table view
        tableView.register(
            UINib(nibName: K.cellNibName, bundle: nil),
            forCellReuseIdentifier: K.cellIdentifier
        )
        loadMessages()
        
    }
    
    func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                if let e = error {
                    print("There was an issue retrieving data from firestore. \(e)")
                } else {
                    self.messages = []
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            if let messageBody = doc.data()[K.FStore.bodyField] as? String, let messageSender = doc.data()[K.FStore.senderField] as? String {
                                self.messages.append(
                                    Message(sender: messageSender, message: messageBody)
                                )
                                
                                //reload the tableView data to reflect the changes
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    
                                    //To scroll to the latest/last message in the list
                                    self.tableView.scrollToRow(
                                        at: IndexPath(row: self.messages.count - 1, section: 0),
                                        at: .top,
                                        animated: true
                                    )
                                }
                            }
                        }
                    }
                }
            }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore. \(e)")
                } else {
                    print("Successfully saved the data!")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                    
                }
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].message
        
        if let currUser = Auth.auth().currentUser?.email {
            if messages[indexPath.row].sender == currUser {
                //This message is from current user
                cell.leftImageView.isHidden = true
                cell.rightImageView.isHidden = false
                cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
                cell.label.textColor = UIColor(named: K.BrandColors.purple)
            } else {
                //This message is from another user
                cell.leftImageView.isHidden = false
                cell.rightImageView.isHidden = true
                cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
                cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
            }
        }
        
        return cell
    }
}
