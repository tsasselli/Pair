//
//  PersonDetailTableViewController.swift
//  Pair Code Challenge
//
//  Created by Travis Sasselli on 8/26/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit

class PersonDetailTableViewController: UITableViewController {

    var pair: [(a: String, b: String?)] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Randomized People \(section + 1)"
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return PeopleController.sharedController.person.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("personNameCell", forIndexPath: indexPath)
        
        let pair = self.pair[indexPath.section]
        
        if indexPath.row == 0 {
            cell.textLabel?.text = pair.a
        } else {
            cell.textLabel?.text = pair.b
        }
        return cell
    }

        

    
   }
