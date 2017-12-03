//
//  ContactsTableViewController.swift
//  LYK
//
//  Created by abdelrahman mohamed on 12/2/17.
//  Copyright © 2017 abdelrahman mohamed. All rights reserved.
//

import UIKit
import FBSDKLoginKit
class ContactsTableViewController: UITableViewController {

    struct StoryBoard {
        static let LoginSegue = "PresentLogin"
        static let cellID = "ContactCell"
    }
    
    
    
    lazy var friends: [Friend] = {
        var list = [Friend]()
        list.append(Friend(name: "Jack sparrow", email: "sparrow90@gmail.com", image: #imageLiteral(resourceName: "pexels")))
        list.append(Friend(name: "Fab Lion", email: "sparrow_lion90@gmail.com", image: #imageLiteral(resourceName: "pexels2")))
        list.append(Friend(name: "Squirl sparrow", email: "Ash.Neil90@gmail.com", image: #imageLiteral(resourceName: "pexels3")))
        list.append(Friend(name: "Dash sparrow", email: "nbadash@gmail.com", image: #imageLiteral(resourceName: "pexels4")))
        return list
    }()
    
    var filteredFriends = [Friend]()
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Check if user logged in, else present login.
        if FBSDKAccessToken.current() == nil {
            performSegue(withIdentifier: StoryBoard.LoginSegue, sender: nil)
        }
        
        // add search
        
        // add offline maybe? 
        
        
        
        getContacts()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Friends"
        navigationItem.searchController = searchController
        definesPresentationContext = true
      
    }

    
    func getContacts() -> Void {
        // For more complex open graph stories, use `FBSDKShareAPI`
        // with `FBSDKShareOpenGraphContent`
        /* make the API call */
        let request = FBSDKGraphRequest.init(graphPath: "/me/friends", parameters: ["fields": "picture,name"], httpMethod: "GET")
        
        _ = request?.start(completionHandler: { (request, results, error) in
            print(results)
            // facebook isn't allowing to get contact list of user anymore. 
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredFriends.count
        }
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.cellID, for: indexPath)
        let data: Friend
        if isFiltering {
            data = filteredFriends[indexPath.row]
        }else{
            data = friends[indexPath.row]
        }
        cell.imageView?.image = data.image
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = data.email
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }
    
    // MARK: - Private instance methods
    
    var searchBarIsEmpty: Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String?, scope: String = "All") {
        guard let text = searchText else {
            return
        }
        filteredFriends = friends.filter({( friend : Friend) -> Bool in
            return friend.name.lowercased().contains(text.lowercased())
        })
        
        tableView.reloadData()
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
}

extension ContactsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text)
    }
    
  
    
    
}
