//
//  PairListTableViewController.swift
//  PairRandomizer
//
//  Created by David Boyd on 5/21/21.
//

import UIKit

class PairListTableViewController: UITableViewController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        EntityController.sharedInstance.loadFromPersistenceStore()
    }

    //MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        presentAlert()
    }
    
    @IBAction func randomizeButtonTapped(_ sender: Any) {
        shuffled()
        tableView.reloadData()
    }
    
    //MARK: - Functions
    func presentAlert() {
        let alertController = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter Full Name Here..."
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let fullNameText = alertController.textFields?.first?.text, !fullNameText.isEmpty else {return}
            
            EntityController.sharedInstance.createEntity(fullName: fullNameText)
            self.tableView.reloadData()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func shuffled() {
        let entities = EntityController.sharedInstance.entities
        let shuffledEntities = entities.shuffled()
        EntityController.sharedInstance.updateEntityOrder(entities: shuffledEntities)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntityController.sharedInstance.entities.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entityCell", for: indexPath)
        
        let entity = EntityController.sharedInstance.entities[indexPath.row]
        
        cell.textLabel?.text = entity.fullName
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let entityToDelete = EntityController.sharedInstance.entities[indexPath.row]
            EntityController.sharedInstance.deleteEntity(entity: entityToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }

}//End of class
