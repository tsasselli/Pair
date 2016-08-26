//
//  PersonListViewController.swift
//  Pair Code Challenge
//
//  Created by Travis Sasselli on 8/26/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit

class PersonListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: TableView DataSource Functions
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Add Person"
    }
    
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   PeopleController.sharedController.person.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("peopleCell", forIndexPath: indexPath)
        
        let people = PeopleController.sharedController.person[indexPath.row]
        cell.textLabel?.text =  " \(indexPath.row + 1) \(people.name)"
        return cell
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let person = PeopleController.sharedController.person[indexPath.row]
            PeopleController.sharedController.deletePerson(person)
        }
        tableView.reloadData()
    }
    @IBAction func addButtonTapped(sender: AnyObject) {
        presentPersonAlertView()
    }

    // MARK: Alert Controller to enter PERSON Name
    
    func presentPersonAlertView() {
        
        let alertView = UIAlertController(title: "Add New Person", message: "Add Person's Name Below", preferredStyle: .Alert)
        alertView.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder? = "Add Person's Name Here:"
        }
        let completeAction = UIAlertAction(title: "Add", style: .Default) { (_) in
            if let text = alertView.textFields?[0].text where !text.isEmpty{
                PeopleController.sharedController.createPeople(text)
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel)  { (_) in
            return
        }
        
        alertView.addAction(completeAction)
        alertView.addAction(cancelAction)
        self.presentViewController(alertView, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetailView" {
            guard let destinationVC = segue.destinationViewController as? PersonDetailTableViewController else { return }
            destinationVC.pair = PeopleController.sharedController.createPeoplePairs(PeopleController.sharedController.person)
        }
    }
}