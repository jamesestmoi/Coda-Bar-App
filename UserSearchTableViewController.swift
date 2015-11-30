//
//  UserSearchTableViewController.swift
//  Bar Design
//
//  Created by James Pickering on 8/9/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var filteredMembers = [Member]()
    var members: [Member] {
        get {
            
            return User.currentUser().members
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
    override func viewWillAppear(animated: Bool) {
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.active {
            
            return filteredMembers.count
        }
        
        return members.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        var member: Member!
        
        if searchController.active == true {
            
            member = filteredMembers[indexPath.row]
        }
        else {
            
            member = members[indexPath.row]
        }
        
        cell.textLabel?.text = member.name.full
        cell.detailTextLabel?.text = member.dob
        
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text)
        
        tableView.reloadData()
    }
    
    func filterContentForSearchText(searchText: String) {
        
        filteredMembers = members.filter({( member ) -> Bool in
            
            let stringMatch = member.name.full.rangeOfString(searchText)
            
            return stringMatch != nil
            
        })
    }
}
