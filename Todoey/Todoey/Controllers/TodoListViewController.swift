//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    //USER DEFAULTS
    //let defaults = UserDefaults.standard
    
    //Creates a plist file in the path using 'appendingPathComponent' method
    //to get the path print -- FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //loading up the data that is already present in the plist array with key "TodoListArray"
        //into itemArray
        //USER DEFAULTS
        //if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            //itemArray = items
        //}
        
        //NSCODER
        //Loads the items from the plist array
        loadItems()
        
    }

    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //can also do
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        //drawback - using the above, the cells which goes invisible when we scroll to the bottom or top will lose its checkmark and creates a new cell in the same place when we scroll back to it
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //drawback - using the above, the cells which goes invisible when we scroll to the bottom or top will be recreated/reused as the bottom cells and have the checkmark there too because it is reused and has checkmark earlier
        
        //To fix, we need to set checkmark w.r.t object instead of the index
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
    
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
        //To remove the grey background whenever a cell is clicked
        //(the cell has a grey background only for few milli-seconds and disappears)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Items", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { alertAction in
            //what will happen ones the user clicks "Add Item" button on out UIAlert
            if textField.text! != "" {
                let newItem = Item()
                newItem.title = textField.text!
                self.itemArray.append(newItem)
                
                //USER DEFAULTS
                //set the itemArray with the key as "TodoListArray"
                //this will add a plist with items added
                //self.defaults.set(self.itemArray, forKey: "TodoListArray")
                
                //NSCODER
                //Will encode the data in itemArray and write it to the plist file
                //and reloads the tableView
                self.saveItems()
                
                //To scroll to the latest/last message in the list
                self.tableView.scrollToRow(
                    at: IndexPath(row: self.itemArray.count - 1, section: 0),
                    at: .top,
                    animated: true
                )
                
            }
            
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        //add the action to the alert created
        alert.addAction(action)
        
        //to show the alert as a modal
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error encoding the item array \(error)")
        }
        
        //reload the data of the table view to also fetch the newly added items
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding the item array \(error)")
            }
        }
    }
    
}


